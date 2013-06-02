require 'spec_helper'

describe CampsiteImporter do
  include FixtureHelpers

  it 'returns all campgrounds in CO' do
    test_api_key = 'aaaaa'

    campgrounds_response = read_xml_fixture('campgrounds.xml')
    stub_request(:get, "http://api.amp.active.com/camping/campgrounds?pstate=CO&api_key=#{test_api_key}").
      to_return(body: campgrounds_response, headers: {'Content-Type' => 'application/xml'})

    campground_response = read_xml_fixture('campground_190308.xml')
    stub_request(:get, "http://api.amp.active.com/camping/campground/details?api_key=#{test_api_key}&contractCode=KOA&parkId=190308").
      to_return(body: campground_response, headers: {'Content-Type' => 'application/xml'})

    campground_site_types = %w(2001 9001 2004)
    %w(2001 10001 2003 2002 9002 9001 3001 2004).each do |site_type|
      campsites_response = %(<resultset contractCode="KOA" count="11" parkId="190308" resultType="campsites" siteType="#{site_type}">)
      if campground_site_types.include?(site_type)
        campsites_response << <<XML
<result Loop="Cripple Creek KOA" Maxeqplen="63" Maxpeople="8" Site="Pull-thru, Full hookups, 50 amp, WiFi" SiteId="1628" SiteReserveType="site-specific" SiteType="RVs" availabilityStatus="Y" mapx="" mapy="" reservationChannel="Web Reservable" sitePhoto="" sitesWithAmps="" sitesWithPetsAllowed="Y" sitesWithSewerHookup="N" sitesWithWaterHookup="N" sitesWithWaterfront=""/>
XML
      end
      campsites_response << %(</resultset>)
      stub_request(:get, "http://api.amp.active.com/camping/campsites?contractCode=KOA&parkId=190308&siteType=#{site_type}&api_key=#{test_api_key}").
        to_return(body: campsites_response, headers: {'Content-Type' => 'application/xml'})
    end

    importer = CampsiteImporter.new(test_api_key, output: StringIO.new)
    importer.import

    campsites = Campsite.all.to_a

    campsite = campsites[0]

    expect(campsites.count).to be 1
    expect(campsite.external_facility_id).to eq 190308
    expect(campsite.name).to eq 'Cripple Creek KOA'
    expect(campsite.contract_code).to eq 'KOA'
    expect(campsite.latitude).to eq 38.7744444
    expect(campsite.longitude).to eq -105.1175
    expect(campsite.street_address).to eq '2576 County Road #81'
    expect(campsite.city).to eq 'Cripple Creek'
    expect(campsite.zip).to eq '80813'
    expect(campsite.state).to eq 'Colorado'
    expect(campsite.reservation_url).to eq 'http://www.reserveamerica.com/campsiteSearch.do?contractCode=KOA&parkId=190308&cmp=39-32--demoactive'
    expect(campsite.phone_number).to eq '7193623279'
    expect(campsite.photo_urls).to eq [
      'http://reserveamerica.com/webphotos/KOA/pid190308/0/180x120.jpg',
      'http://reserveamerica.com/webphotos/KOA/pid190308/1/180x120.jpg',
      'http://reserveamerica.com/webphotos/KOA/pid190308/2/180x120.jpg'
    ]
    expect(campsite.description).to eq <<EOT.squish
At 10,000 feet above sea level, the Cripple Creek KOA is the highest KOA in the world. It is always cool (normal mid-June to mid-August highs 70-80, normal lows 40-50 degrees Fahrenheit) and never humid. There are glorious sunsets with quiet, restful nights and fabulous star gazing . We have a Colorado high country setting, a peaceful mountain location bordering BLM forest land. The Cripple Creek/Victor area is full of things to do - Mollie Kathleen Gold Mine, Cripple Creek melodrama, steam train ride between Cripple Creek and Victor, Florissant Fossil Beds National Monument, CC/Victor Gold Mining Company which is a huge commercial gold reclamation operation, Cripple Creek Museum, nearby horseback riding , hiking up Trachyte Knob adjacent to the campground , fishing at Skaguay or Eleven Mile reservoirs, as well as numerous casinos in Cripple Creek for your gambling pleasure. It is always fun to look for the donkeys that have roamed around Cripple Creek for years. The campground is located centrally to the Colorado Springs/Pike&amp;#39;s Peak area attractions as well as the Royal Gorge Country attractions, each area being 45 minutes to one hour away. Guests use us as a base-camp for going to these other areas. We can keep you busy for days! Our staff is able to help with reservations for our guests at numerous Colorado Springs and Royal Gorge attractions, e.g. Colorado Springs/Manitou Springs Cog Railway, Flying W Ranch in Colorado Springs, Royal Gorge Route Train, Echo Canyon or other rafting companies in the Royal Gorge area. At the campground our RV sites are spacious pull-thrus with open spectacular views of the high mountain countryside. Tent campers may choose a wilderness site in the aspen trees or a deluxe tent site that has a ramada cover, electricity and water. We have ten camping cabins and two camping lodges . We offer pancake breakfast service on Saturday and Sunday from Memorial Day to Labor Day for an additional charge. There is a camping kitchen for use by our guests. Evening meal service is available for groups upon request. We have a game room, banana bikes (for kids). All of our sites have fire pits for great campfires on cool evenings. Children 6 years and younger are free and pets are welcome. Leave the hot weather behind join us for COOL weather in our serene mountain setting!
EOT

    expect(campsite.amenities.map(&:name)).to eq [
      'Electricity Hookups',
      'Pets Allowed',
      'Water Hookup'
    ]
    expect(campsite.activities.map(&:name)).to eq [
      'Antiquing',
      'Fishing',
      'Gambling in Cripple Creek',
      'Golfing',
      'Hiking & Biking',
      'Horseback Riding',
      'Museums & Historical Tours'
    ]
    expect(campsite.site_types.map(&:name)).to eq [
      'RV Sites',
      'Day Use',
      'Boat Site'
    ]

    amenities = Amenity.all.to_a
    expect(amenities.size).to be 5

    activities = Activity.all.to_a
    expect(activities.size).to be 7

    site_types = SiteType.all.to_a
    expect(site_types.size).to be 3
  end
end

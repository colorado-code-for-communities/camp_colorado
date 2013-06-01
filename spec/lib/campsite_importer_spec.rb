require 'spec_helper'

describe CampsiteImporter do
  it 'returns all campgrounds in CO' do
    test_api_key = 'aaaaa'

    campgrounds_response = <<XML
<resultset amenity="4005" count="4" lengthOfStay="5" pstate="CO" resultType="campgrounds">
<result agencyIcon="" agencyName="" availabilityStatus="Y" contractID="KOA" contractType="PRIVATE" facilityID="190308" facilityName="Cripple Creek KOA" faciltyPhoto="/webphotos/KOA/pid190308/0/80x53.jpg" latitude="38.7744444" longitude="-105.1175" regionName="" reservationChannel="Web Reservable" shortName="A308" sitesWithAmps="Y" sitesWithPetsAllowed="Y" sitesWithSewerHookup="N" sitesWithWaterHookup="Y" sitesWithWaterfront="" state="CO"/>
<result agencyIcon="" agencyName="" availabilityStatus="Y" contractID="KOA" contractType="PRIVATE" facilityID="190164" facilityName="Grand Junction KOA" faciltyPhoto="/webphotos/KOA/pid190164/0/80x53.jpg" latitude="39.0355556" longitude="-108.5297222" regionName="" reservationChannel="Web Reservable" shortName="A164" sitesWithAmps="N" sitesWithPetsAllowed="Y" sitesWithSewerHookup="Y" sitesWithWaterHookup="Y" sitesWithWaterfront="" state="CO"/>
</resultset>
XML
    stub_request(:get, "http://api.amp.active.com/camping/campgrounds?pstate=CO&api_key=#{test_api_key}").
      to_return(body: campgrounds_response, headers: {'Content-Type' => 'application/xml'})

    campground_response = <<XML
<detailDescription alert="" contractID="KOA" description="At 10,000 feet above sea level, the  Cripple Creek  KOA is the  highest KOA  in the world. It is always cool (normal mid-June to mid-August highs 70-80, normal lows 40-50 degrees Fahrenheit) and never humid. There are glorious  sunsets  with quiet, restful nights and fabulous  star gazing  . We have a  Colorado  high country setting, a peaceful mountain location bordering BLM forest land.  The  Cripple Creek/Victor  area is full of things to do -  Mollie Kathleen Gold Mine, Cripple Creek  melodrama, steam train ride between  Cripple Creek  and  Victor, Florissant Fossil Beds  National Monument, CC/Victor Gold Mining Company which is a huge commercial gold reclamation operation,  Cripple Creek  Museum, nearby  horseback riding  , hiking up Trachyte Knob adjacent to the  campground  , fishing at  Skaguay  or  Eleven Mile  reservoirs, as well as numerous casinos in Cripple Creek for your gambling pleasure. It is always fun to look for the donkeys that have roamed around Cripple Creek for years.  The  campground  is located centrally to the  Colorado Springs/Pike&amp;amp;#39;s Peak  area attractions as well as the  Royal Gorge  Country attractions, each area being 45 minutes to one hour away. Guests use us as a  base-camp  for going to these other areas. We can keep you busy for days! Our staff is able to help with reservations for our guests at numerous  Colorado Springs  and  Royal Gorge  attractions, e.g. Colorado Springs/Manitou Springs Cog Railway, Flying W Ranch in Colorado Springs, Royal Gorge Route Train, Echo Canyon or other rafting companies in the Royal Gorge area.  At the  campground  our RV sites are spacious pull-thrus with open spectacular views of the high mountain countryside.  Tent campers  may choose a wilderness site in the aspen trees or a  deluxe tent site  that has a ramada cover, electricity and water. We have ten  camping cabins  and two  camping lodges . We offer pancake breakfast service on Saturday and Sunday from Memorial Day to Labor Day for an additional charge. There is a  camping kitchen  for use by our guests. Evening meal service is available for groups upon request. We have a game room, banana bikes (for kids). All of our sites have fire pits for great  campfires  on cool evenings. Children 6 years and younger are free and pets are welcome.  Leave the hot weather behind join us for COOL weather in our serene mountain setting!" drivingDirection="From Divide Colorado, Take Hwy 67 South for 13 Miles, to CR 81 (to Victor) South 1/2 mile, campground is on left." facilitiesDescription="" facility="Cripple Creek KOA" facilityID="190308" fullReservationUrl="http://www.reserveamerica.com/campsiteSearch.do?contractCode=KOA&amp;parkId=190308&amp;cmp=39-32--demoactive" importantInformation="" latitude="38.7744444" longitude="-105.1175" nearbyAttrctionDescription="" note="" orientationDescription="" recreationDescription="" regionName="KOA Region" reservationUrl="/campsiteSearch.do?contractCode=KOA&amp;parkId=190308&amp;cmp=39-32--demoactive">
<address city="Cripple Creek" country="United States" shortName="A308" state="Colorado" streetAddress="2576 County Road #81" zip="80813"/>
<photo realUrl="/webphotos/KOA/pid190308/0/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190308/0/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190308/0/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190308/1/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190308/1/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190308/1/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190308/2/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190308/2/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190308/2/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190308/3/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190308/3/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190308/3/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190308/4/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190308/4/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190308/4/540x360.jpg&quot; onclick=&qquot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190308/5/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190308/5/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190308/5/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<informationLink link="" title=""/>
<contact name="Direct Line" number=""/>
<contact name="Ranger Station" number="7193623279"/>
<amenity distance="Within Facility" name="Antiquing"/>
<amenity distance="Within Facility" name="Fishing"/>
<amenity distance="Within Facility" name="Gambling in Cripple Creek"/>
<amenity distance="Within Facility" name="Golfing"/>
<amenity distance="Within Facility" name="Hiking &amp;amp; Biking"/>
<amenity distance="Within Facility" name="Horseback Riding"/>
<amenity distance="Within Facility" name="Museums &amp;amp; Historical Tours"/>
<bulletin/>
</detailDescription>
XML
    stub_request(:get, "http://api.amp.active.com/camping/campground/details?api_key=#{test_api_key}&contractCode=KOA&parkId=190308").
      to_return(body: campgrounds_response, headers: {'Content-Type' => 'application/xml'})

    campground_response = <<XML
<detailDescription alert="" contractID="KOA" description=" Take a Virtual Tour of our Campground now!   News Flash! We have just added 2 new studio lodges with kitchenette &amp;amp; full bath.  This Western Colorado KOA campground is centrally located between the high desert and hiking trails of the Colorado National Monument and the tree-shaded lakes of the Grand Mesa, featuring fishing, ATV and hiking trails, and moose, elk and deer hunting. Nearby, mountain bike trails in all directions offer terrain very similar to Moab without the crowds. The Colorado River offers rafting from &amp;quot;mild&amp;quot;, 2-hour trips to &amp;quot;WILD&amp;quot; full-day trips; you can even catch a horseback ride! Bring your rod and reel, because great trout fishing is just a short drive away from the campground.  Camping at our KOA campground has something for everyone- and every kind of rig! All pull through sites are large, 30 or 50 amp sites with fire pits &amp;amp; tables for your camping enjoyment. No RV? No problem! Our traditional cabins are cozy one-room cabins that have a full bed and a set of bunk beds, the larger two-room cabin has a full bed in one room and two sets of bunk beds in the other. All cabins have mini fridges, fire pits/Barbeque combo&amp;amp;#39;s and tables. Want and upgrade from the traditional cabin we have new studio lodges with kitchenette&amp;amp;#39;s and bathrooms We even have a limited number of tent sites- all including electric and water, and just steps away from bathrooms and showers.  Kids will love the game room with pool, air hockey, and ping pong. For some outside fun, how about a round of mini golf or spend some time in the playground area. From Memorial day to Labor day cool off in the pool or take in a movie with the kids starts about dusk. There&amp;amp;#39;s even a &amp;quot;bark park&amp;quot; for pets.  Come spend some time at our family-friendly campground. You&amp;amp;#39;ll be glad you did!" drivingDirection="I-70 East Bound(from Utah) Exit 26. Right on Highway 50 also the I-70 Business loop. Stay on Highway 50( it could be US 50 on your GPS) by following the road signs to Montrose. After you cross the Colorado River the KOA is about 2.5 miles on the right.  I-70 West Bound (from Glenwood Springs) Take exit 37. 1 mile on the I-70 Business loop. Left on Highway 141(by Wendy&amp;apos;s) it is about 5.5 miles to Highway 50. Right on Highway 50 (this could be US 50 on your GPS). It is about 3.5 miles to the KOA we are on the left. Go past us, make a u-turn at the Fair Grounds entrance" facilitiesDescription="" facility="Grand Junction KOA" facilityID="190164" fullReservationUrl="http://www.reserveamerica.com/campsiteSearch.do?contractCode=KOA&amp;parkId=190164&amp;cmp=39-32--demoactive" importantInformation="" latitude="39.0355556" longitude="-108.5297222" nearbyAttrctionDescription="" note="" orientationDescription="" recreationDescription="" regionName="KOA Region" reservationUrl="/campsiteSearch.do?contractCode=KOA&amp;parkId=190164&amp;cmp=39-32--demoactive">
<address city="Grand Junction" country="United States" shortName="A164" state="Colorado" streetAddress="2819 Highway 50" zip="81503"/>
<photo realUrl="/webphotos/KOA/pid190164/0/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190164/0/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190164/0/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190164/1/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190164/1/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190164/1/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190164/2/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190164/2/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190164/2/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190164/3/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190164/3/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190164/3/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190164/4/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190164/4/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190164/4/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<photo realUrl="/webphotos/KOA/pid190164/5/180x120.jpg" url="&lt;img width=&quot;180&quot; height=&quot;120&quot; src=&quot;/webphotos/KOA/pid190164/5/180x120.jpg&quot; class=&quot;PopBoxImageSmall&quot; pbsrc=&quot;/webphotos/KOA/pid190164/5/540x360.jpg&quot; onclick=&quot;PopPhoto(this,50,'PopBoxImageLarge');&quot;   /&gt;"/>
<informationLink link="" title=""/>
<contact name="Direct Line" number="1112223333"/>
<contact name="Ranger Station" number="9702422527"/>
<amenity distance="Within Facility" name="Mini golf"/>
<amenity distance="Within Facility" name="Pedal Karts"/>
<amenity distance="Within Facility" name="Playground"/>
<bulletin/>
</detailDescription>
XML
    stub_request(:get, "http://api.amp.active.com/camping/campground/details?api_key=#{test_api_key}&contractCode=KOA&parkId=190164").
      to_return(body: campgrounds_response, headers: {'Content-Type' => 'application/xml'})

    CampsiteImporter.new(test_api_key).import

    campsites = Campsite.all.to_a
    expect(campsites.count).to be 2
    expect(campsites[0]).to eq Campsite.new(
      external_facility_id: 190308,
      name: 'Cripple Creek KOA',
      contract_code: 'KOA',
      latitude: 38.7744444,
      longitude: -105.1175,
      street_address: '2576 County Road #81',
      city: 'Cripple Creek',
      zip: '80813',
      state: 'CO',
      reservation_url: 'http://www.reserveamerica.com/campsiteSearch.do?contractCode=KOA&amp;parkId=190308&amp;cmp=39-32--demoactive',
      phone_number: '7193623279'
    )
    expect(campsites[0].amenities.map(&:name)).to eq [
      'Electricity Hookups',
      'Pets Allowed',
      'Water Hookup'
    ]
    expect(campsites[0].activities.map(&:name)).to eq [
      'Antiquing',
      'Fishing',
      'Gambling in Cripple Creek',
      'Golfing',
      'Hiking & Biking',
      'Horseback Riding',
      'Museums & Historical Tours'
    ]
    expect(campsites[1]).to eq Campsite.new(
      external_facility_id: 190164,
      name: 'Grand Junction KOA',
      contract_code: 'KOA',
      latitude: 39.0355556,
      longitude: -108.5297222,
      street_address: '2819 Highway 50',
      city: 'Grand Junction',
      zip: '81503',
      state: 'CO',
      reservation_url: 'http://www.reserveamerica.com/campsiteSearch.do?contractCode=KOA&amp;parkId=190164&amp;cmp=39-32--demoactive',
      phone_number: '1112223333'
    )
    expect(campsites[1].activities.map(&:name)).to eq [
      'Mini golf',
      'Pedal Karts',
      'Playground'
    ]

    #amenities = Amenity.all.to_a
    #expect(amenities.count).to be ??

    activities = Activity.all.to_a
    expect(activities.count).to be 10
  end
end

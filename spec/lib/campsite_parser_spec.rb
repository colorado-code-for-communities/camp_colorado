require 'spec_helper'

describe CampsiteParser do
  it 'returns all campgrounds in CO' do
    campgrounds = CampsiteParser.new.campgrounds
    expect(campgrounds.count).to be > 1
    expect(campgrounds[0]).to be_a Campsite
  end

end

require 'spec_helper'

describe Amenity do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end

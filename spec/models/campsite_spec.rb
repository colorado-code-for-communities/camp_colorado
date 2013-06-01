require 'spec_helper'

describe Campsite do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:latitude) }
    it { should validate_numericality_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_numericality_of(:longitude) }
  end
end

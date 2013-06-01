# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campsite do
    sequence(:name) { |n| "Campsite #{n}" }
    address "MyString"
    latitude 1.5
    longitude 1.5
    open_date "2013-06-01"
    close_date "2013-06-01"
    phone_number "MyString"
    website "MyString"
    reservation_url "MyString"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coordinate do
    lat "9.99"
    long "9.99"
    solr_id 1
  end
end

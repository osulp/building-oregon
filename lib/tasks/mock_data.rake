require 'json'

namespace :data do
  desc "Loads Mock Data Into Solr"
  task :mock do
    require "#{Rails.root}/lib/building_oregon/fixture_loader"
    loader = BuildingOregon::FixtureLoader.new("mock_data.json")
    loader.load!
  end
end
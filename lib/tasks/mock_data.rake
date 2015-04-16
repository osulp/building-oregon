require 'json'

namespace :data do
  desc "Loads Mock Data Into Solr"
  task :mock => :environment do
    require "#{Rails.root}/lib/building_oregon/fixture_loader"
    json = JSON.parse(File.read(Rails.root.join("lib/tasks/mock_data.json")))
    loader = BuildingOregon::FixtureLoader.new(json, Blacklight.default_index.connection)
    loader.load!
  end
end

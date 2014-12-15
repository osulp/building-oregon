require 'json'

namespace :data do
  desc "Loads Mock Data Into Solr"
  task :mock do
    Blacklight.solr
    Blacklight.solr.delete_by_query "*:*"
    Blacklight.solr.commit
    File.foreach(File.join(Rails.root, 'tmp', 'mock_data.txt')) do |line|
      Blacklight.solr.add(JSON.parse line.gsub(/:(\w+)/){"\"#{$1}\""}.gsub('=>', ':'))
    end
    Blacklight.solr.commit
  end
end
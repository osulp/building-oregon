require 'json'

namespace :data do
  desc "Loads Mock Data Into Solr"
  task :mock do
    Blacklight.solr
    Blacklight.solr.delete_by_query "*:*"
    Blacklight.solr.commit
    file = File.join(Rails.root, 'tmp', 'mock_data.json')
    Blacklight.solr.add(JSON.parse File.read(file))
    Blacklight.solr.commit
  end
end
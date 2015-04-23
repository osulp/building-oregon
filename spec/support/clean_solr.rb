RSpec.configure do |config|
  config.before(:each) do
    solr = Blacklight.default_index.connection
    solr.delete_by_query("*:*")
    solr.commit
  end
end

require 'json'

module BuildingOregon
  class FixtureLoader
    def self.call(file)
      new(file).load!
    end

    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def load!
      Blacklight.solr
      Blacklight.solr.delete_by_query "*:*"
      Blacklight.solr.commit
      file = File.join(Rails.root, 'lib', 'tasks', @file)
      Blacklight.solr.add(JSON.parse File.read(file))
      Blacklight.solr.commit
    end
  end
end

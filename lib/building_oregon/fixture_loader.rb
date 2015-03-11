require 'json'

module BuildingOregon
  class FixtureLoader
    def self.call(json, solr_repository)
      new(json, solr_repository).load!
    end

    attr_accessor :json, :solr_repository

    def initialize(json, solr_repository)
      @json = json
      @solr_repository = solr_repository
    end

    def load!
      self.create_solr_instance
      self.delete_solr_index
      self.load_file
    end

    def delete_solr_index
      solr_repository.delete_by_query "*:*"
      self.commit
    end

    def create_solr_instance
      solr_repository
    end

    def commit
      solr_repository.commit
    end

    def load_file
      solr_repository.add(json)
      self.commit
    end
  end
end

module BuildingOregon
  module Catalog
    module FacetConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          METADATA["Facets"].each_pair do |field, metadata|
            config.add_facet_field metadata, :label => field
          end
          config.add_facet_fields_to_solr_request!
        end
      end
    end
  end
end

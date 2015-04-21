module BuildingOregon
  module Catalog
    module FacetConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          METADATA["Facets"].each_pair do |field, metadata|
            config.add_facet_field metadata, :label => field, :helper_method => :controlled_label, :limit => 10
          end
          config.add_facet_fields_to_solr_request!
        end
      end
    end
  end
end

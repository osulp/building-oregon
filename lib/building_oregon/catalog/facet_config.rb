module BuildingOregon
  module Catalog
    module FacetConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_facet_field 'title_ssim', :label => 'title'
          config.add_facet_field 'description_ssim', :label => 'description'
          config.add_facet_field 'creator_ssim', :label => 'creator'

          config.add_facet_fields_to_solr_request!
        end
      end
    end
  end
end
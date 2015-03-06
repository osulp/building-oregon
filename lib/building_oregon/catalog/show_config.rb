module BuildingOregon
  module Catalog
    module ShowConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_show_field 'desc_metadata__title_ssim', :label => 'Title'
          config.add_show_field 'desc_metadata__description_ssim', :label => 'Description'
          config.add_show_field 'desc_metadata__creator_ssim', :label => 'Creator'
          config.add_show_field 'desc_metadata__view_ssm', :label => 'View'
          config.add_show_field 'desc_metadata__provenance_ssm', :label => 'provenance'
          config.add_show_field 'desc_metadata__temporal_ssm', :label => 'Time Period'
          config.add_show_field 'desc_metadata__location_label_ssm', :label => 'Location'
        end
      end
    end
  end
end

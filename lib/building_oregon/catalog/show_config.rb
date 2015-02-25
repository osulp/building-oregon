module BuildingOregon
  module Catalog
    module ShowConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_show_field 'desc_metadata__title_ssim', :label => 'Title'
          config.add_show_field 'desc_metadata__description_ssim', :label => 'Description'
          config.add_show_field 'desc_metadata__creator_ssim', :label => 'Creator'
        end
      end
    end
  end
end
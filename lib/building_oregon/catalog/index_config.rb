module BuildingOregon
  module Catalog
    module IndexConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.index.title_field = "desc_metadata__title_ssim"
          config.add_index_field 'desc_metadata__description_ssim', :label => 'description'
          config.add_index_field 'desc_metadata__creator_ssim', :label => 'creator'
        end
      end
    end
  end
end

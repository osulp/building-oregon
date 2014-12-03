module BuildingOregon
  module Catalog
    module IndexConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_index_field 'title_ssim', :label => 'title'
          config.add_index_field 'description_ssim', :label => 'description'
          config.add_index_field 'creator_ssim', :label => 'creator'
        end
      end
    end
  end
end
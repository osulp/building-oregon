module BuildingOregon
  module Catalog
    module ShowConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_show_field 'title_ssim', :label => 'title'
          config.add_show_field 'description_ssim', :label => 'Description'
          config.add_show_field 'creator_ssim', :label => 'creator'
        end
      end
    end
  end
end
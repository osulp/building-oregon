module BuildingOregon
  module Catalog
    module ShowConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_show_field 'title_ssim', :label => 'Title'
          config.add_show_field 'description_ssim', :label => 'Description'
          config.add_show_field 'creator_ssim', :label => 'Creator'
        end
      end
    end
  end
end
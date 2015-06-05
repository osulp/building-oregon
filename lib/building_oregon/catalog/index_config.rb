module BuildingOregon
  module Catalog
    module IndexConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.index.title_field = "desc_metadata__title_ssim"

          METADATA["Index"].each_pair do |field, metadata|
            config.add_index_field metadata, :label => field.titleize, :helper_method => :controlled_index_label
          end
        end
      end
    end
  end
end

module BuildingOregon
  module Catalog
    module ShowConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          METADATA["Show"].each_pair do |field, metadata|
            config.add_show_field metadata, :label => field, :accessor => :build_link
          end
        end
      end
    end
  end
end

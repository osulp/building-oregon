module BuildingOregon
  module Catalog
    module ShowConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
        end
      end
    end
  end
end

module BuildingOregon
  module Catalog
    module SortConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_sort_field "score desc", :label => "Relevance"
        end
      end
    end
  end
end

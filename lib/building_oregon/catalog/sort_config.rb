module BuildingOregon
  module Catalog
    module SortConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_sort_field "score desc", :label => "Relevance"
          config.add_sort_field "desc_metadata__title_si asc", :label => "Title A-Z"
          config.add_sort_field "desc_metadata__title_si desc", :label => "Title Z-A"
        end
      end
    end
  end
end

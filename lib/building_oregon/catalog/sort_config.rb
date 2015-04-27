module BuildingOregon
  module Catalog
    module SortConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_sort_field "score desc", :label => "Relevance"
          config.add_sort_field "sort_date_desc_dtsi asc", :label => "Date Decending"
          config.add_sort_field "sord_date_asc_dtsi asc", :label => "Date Ascending"
          config.add_sort_field "system_create_dtsi desc", :label => "Recently Added"
        end
      end
    end
  end
end

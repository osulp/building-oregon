module BuildingOregon
  module Catalog
    module SearchConfig
      extend ActiveSupport::Concern
      included do
        configure_blacklight do |config|
          config.add_search_field 'all_fields', :label => 'All Fields' do |field|
            field.solr_parameters = {:qf => "all_text_timv"}
          end
        end
      end
    end
  end
end
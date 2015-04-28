# -*- encoding : utf-8 -*-
#
class CatalogController < ApplicationController  

  include Blacklight::Catalog

  #Config Files for Building Oregon
  include BuildingOregon::Catalog::FacetConfig
  include BuildingOregon::Catalog::IndexConfig
  include BuildingOregon::Catalog::MapConfig
  include BuildingOregon::Catalog::SearchConfig
  include BuildingOregon::Catalog::ShowConfig
  include BuildingOregon::Catalog::SortConfig

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10 
    }
    config.add_field_configuration_to_solr_request!
  end
  self.search_params_logic += [:exclude_unreviewed_items]
  self.search_params_logic += [:only_building_oregon]
  def index
    super
    if params[:view] != "list"
      @map_response,_ = search_results(params, search_params_logic+[:max_rows])
    end
  end
end 

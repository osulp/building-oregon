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

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10 
    }

  end
end 

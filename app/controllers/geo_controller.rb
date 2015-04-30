class GeoController < ApplicationController
  include Blacklight::Base
  copy_blacklight_config_from(CatalogController)
  respond_to :json

  self.search_params_logic += [:exclude_unreviewed_items]
  self.search_params_logic += [:only_building_oregon]
  self.search_params_logic += [:only_lat_longs]
  self.search_params_logic += [:distance_query]

  def frame
    nearby_results, _ = search_results(params.merge({:rows => 500, :page => nil}), search_params_logic)
    documents = nearby_results.docs
    respond_with geojson(documents)
  end

  private

  def geojson(documents)
    BlacklightMaps::GeojsonExport.new(self, documents).to_geojson
  end
end

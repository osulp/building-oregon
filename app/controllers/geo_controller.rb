class GeoController < ApplicationController
  include Blacklight::Base
  copy_blacklight_config_from(CatalogController)
  respond_to :json

  self.search_params_logic += [:exclude_unreviewed_items]
  self.search_params_logic += [:only_building_oregon]
  self.search_params_logic += [:only_lat_longs]
  self.search_params_logic += [:distance_query]

  def nearby
    nearby_results, _ = get_search_results(geo_params, {:rows => 10000})
    documents = nearby_results.docs
    respond_with geojson(documents)
  end

  private

  def geojson(documents)
    BlacklightMaps::GeojsonExport.new(self, documents).to_geojson
  end

  def geo_params
    params.slice(:latitude, :longitude, :distance)
  end
end

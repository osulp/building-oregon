module MapsHelper
  include BlacklightMapsHelper
  include Blacklight::CatalogHelperBehavior

  def serialize_geojson
    export = BlacklightMaps::GeojsonExport.new(controller,
                                               @map_response.docs)
    export.to_geojson
  end

  def show_pagination?(*args)
    if document_index_view_type == :maps
      false
    else
      super
    end
  end
end

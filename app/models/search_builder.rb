class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  def exclude_unreviewed_items(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-reviewed_ssim:\"false\""
  end

  def only_images(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "desc_metadata__type_label_sim:\"Image$http://purl.org/dc/dcmitype/Image\""
  end

  def only_building_oregon(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "desc_metadata__set_sim:\"#{RSolr.solr_escape("http://oregondigital.org/resource/oregondigital:building-or")}\""
  end

  def only_lat_longs(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "desc_metadata__latitude_teim:[* TO *]"
  end

  def distance_query(solr_parameters)
    solr_parameters[:fq] ||= []
    if blacklight_params[:northeast] && blacklight_params[:southwest]
      solr_parameters[:fq] << BuildingOregon::FrameQueryGenerator.new(*blacklight_params.slice(:southwest, :northeast).values).to_s
    end
  end
end


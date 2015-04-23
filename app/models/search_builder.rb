class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  def exclude_unreviewed_items(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-reviewed_ssim:\"false\""
  end

  def only_building_oregon(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "desc_metadata__set_sim:\"#{RSolr.solr_escape("http://oregondigital.org/resource/oregondigital:building-or")}\""
  end
end

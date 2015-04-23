class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  def exclude_unreviewed_items(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-reviewed_ssim:\"false\""
  end
end

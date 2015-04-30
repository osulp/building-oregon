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

  def only_lat_longs(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "desc_metadata__latitude_teim:[* TO *]"
  end

  def distance_query(solr_parameters)
    solr_parameters[:fq] ||= []
    if blacklight_params[:northeast] && blacklight_params[:southwest]
      solr_parameters[:fq] << FrameQueryGenerator.new(*blacklight_params.slice(:southwest, :northeast).values).to_s
    end
  end
end

class FrameQueryGenerator
  attr_reader :southwest, :northeast
  def initialize(southwest, northeast)
    @southwest = southwest
    @northeast = northeast
  end

  def to_s
    "#{field}:[#{southwest} TO #{northeast}]"
  end

  private

  def field
    "desc_metadata__coordinates_llsim"
  end
end

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
    if blacklight_params[:latitude] && blacklight_params[:longitude]
      solr_parameters[:fq] << DistanceQueryGenerator.new(*blacklight_params.slice(:latitude, :longitude, :distance).values).to_s
    end
  end
end

class DistanceQueryGenerator
  attr_reader :latitude, :longitude, :distance
  def initialize(latitude, longitude, distance=20)
    @latitude = latitude
    @longitude = longitude
    @distance = distance
  end

  def to_s
    "{!geofilt sfield=#{field} pt=#{latitude},#{longitude} d=#{distance}}"
  end

  private

  def field
    "desc_metadata__coordinates_llsim"
  end
end

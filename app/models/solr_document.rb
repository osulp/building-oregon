# -*- encoding : utf-8 -*-
class SolrDocument 

  def initialize(*args)
    super
    if self["desc_metadata__latitude_ssm"] != nil
      self["coords_ssim"] = [coordinates]
    end
  end

  include Blacklight::Solr::Document    
      # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_display
  extension_parameters[:marc_format_type] = :marcxml
  
  field_semantics.merge!(
                         :title => "title_display",
                         :author => "author_display",
                         :language => "language_facet",
                         :format => "format"
                         )



  # self.unique_key = 'id'
  
  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension( Blacklight::Document::Email )
  
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension( Blacklight::Document::Sms )

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Solr::Document::ExtendableClassMethods#field_semantics
  # and Blacklight::Solr::Document#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension( Blacklight::Document::DublinCore)

  def photo_path
    file_distributor.path
  end

  def build_link(field)
    Array(self[field]).map do |value|
      BuildingOregon::ControlledValue.new(value).to_s
    end
  end

  def coordinates
    [
      self["desc_metadata__title_ssm"],
      self["desc_metadata__latitude_ssm"],
      self["desc_metadata__longitude_ssm"]
    ].join("-|-")
  end

  private

  def file_distributor
    fd = BuildingOregon::FileDistributor.new(self.id)
    fd.source_site="http://oregondigital.library.oregonstate.edu/"
    fd.extension=".jpg"
    fd
  end

end

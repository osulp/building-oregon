# -*- encoding : utf-8 -*-
class SolrDocument 

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
  SolrDocument.use_extension( Blacklight::Solr::Document::Email )
  
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension( Blacklight::Solr::Document::Sms )

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Solr::Document::ExtendableClassMethods#field_semantics
  # and Blacklight::Solr::Document#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension( Blacklight::Solr::Document::DublinCore)    

  def photo_path
    file_distributor.path
  end

  def build_location_links
    link_generator(self['desc_metadata__location_label_ssm']).extract_links
  end

  private

  def link_generator(location_array)
    BuildingOregon::LinkGenerator.new(location_array)
  end

  def file_distributor
    fd = BuildingOregon::FileDistributor.new(self.id)
    fd.source_url="http://oregondigital.library.oregonstate.edu"
    fd.extension=".jpg"
    fd
  end

end

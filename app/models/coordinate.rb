class Coordinate < ActiveRecord::Base
  validates_presence_of :solr_id
end

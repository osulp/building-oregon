class Coordinate < ActiveRecord::Base
  validates_presence_of :solr_id
  validates_presence_of :lat
  validates_presence_of :long
end

class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.decimal :lat
      t.decimal :long
      t.integer :solr_id

      t.timestamps
    end
  end
end

class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :setting_name
      t.text :value

      t.timestamps
    end
  end
end

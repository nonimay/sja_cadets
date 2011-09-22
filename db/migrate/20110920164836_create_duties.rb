class CreateDuties < ActiveRecord::Migration
  def self.up
    create_table :duties do |t|
      t.string :event
      t.string :nature
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.integer :quota

      t.timestamps
    end
  end

  def self.down
    drop_table :duties
  end
end

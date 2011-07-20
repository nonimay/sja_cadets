class CreateCadets < ActiveRecord::Migration
  def self.up
    create_table :cadets do |t|
      t.integer :member_number
      t.string :firstname
      t.string :lastname
      t.date :dob
      t.string :street
      t.string :town
      t.string :county
      t.string :postcode

      t.timestamps
    end
  end

  def self.down
    drop_table :cadets
  end
end

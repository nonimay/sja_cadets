class CreateEmergencyContacts < ActiveRecord::Migration
  def self.up
    create_table :emergency_contacts do |t|
      t.string :name
      t.string :number
      t.string :relationship

      t.timestamps
    end
  end

  def self.down
    drop_table :emergency_contacts
  end
end

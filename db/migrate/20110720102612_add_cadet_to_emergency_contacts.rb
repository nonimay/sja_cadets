class AddCadetToEmergencyContacts < ActiveRecord::Migration
  def self.up
    add_column :emergency_contacts, :cadet_id, :integer
    add_index :emergency_contacts, :cadet_id
  end

  
  def self.down
    remove_column :emergency_contacts, :cadet_id
    remove_column :emergency_contacts, :cadet
  end
end

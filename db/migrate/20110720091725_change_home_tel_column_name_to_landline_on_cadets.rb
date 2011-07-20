class ChangeHomeTelColumnNameToLandlineOnCadets < ActiveRecord::Migration
  def self.up
    rename_column :cadets, :home_tel, :landline
  end

  def self.down
  end
end

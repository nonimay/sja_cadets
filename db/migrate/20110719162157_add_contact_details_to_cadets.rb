class AddContactDetailsToCadets < ActiveRecord::Migration
  def self.up
    add_column :cadets, :email, :string
    add_column :cadets, :home_tel, :string
    add_column :cadets, :mobile, :string
  end

  def self.down
    remove_column :cadets, :mobile
    remove_column :cadets, :home_tel
    remove_column :cadets, :email
  end
end

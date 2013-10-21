class CreateCourts < ActiveRecord::Migration
  def self.up
    create_table :courts do |t|
      t.string :name
    end
    add_index :courts, :name
  end

  def self.down
    drop_table :courts
  end
end

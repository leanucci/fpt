class CreateSlugs < ActiveRecord::Migration
  def self.up
    create_table :slugs do |t|
      t.string :name, :limit => 100
      t.string :sluggable_type, :limit => 25
      t.integer :sluggable_id
      t.timestamps
    end
    add_index :slugs, [:name, :sluggable_type], :unique
    add_index :slugs, :sluggable_id
  end

  def self.down
    drop_table :slugs
  end
end

class CreateFriendlyIdSlugs < ActiveRecord::Migration

  def self.up
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 40
      t.datetime :created_at
    end
    add_column :users, :slug, :string
    add_column :customers, :slug, :string
    add_column :suppliers, :slug, :string

    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type], :unique => true
    add_index :friendly_id_slugs, :sluggable_type
    
    add_index :users, :slug, unique: true
    add_index :customers, :slug, unique: true
    add_index :suppliers, :slug, unique: true
  end

  def self.down
    drop_table :friendly_id_slugs
  end
end

class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :complete_name
      t.string :short_name
      t.string :acronym_name
      t.string :nickname_name
    end
  end

  def self.down
    drop_table :teams
  end
end

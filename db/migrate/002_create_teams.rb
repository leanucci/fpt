class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :full_name, :short_name, :acronym_name, :nickname_name
    end
  end

  def self.down
    drop_table :teams
  end
end

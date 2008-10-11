class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :matches, :standing_id
    add_index :matches, :home_team_id
    add_index :matches, :away_team_id
    add_index :participations, [:tournament_id, :team_id, :id], :unique => true
    add_index :standings, :tournament_id
    add_index :teams, :short_name, :unique
  end

  def self.down
    remove_index :matches, :standing_id
    remove_index :matches, :home_team_id
    remove_index :matches, :away_team_id
    remove_index :participations, [:tournament_id, :team_id, :id]
    remove_index :standings, :tournament_id
    remove_index :teams, :short_name
  end
end

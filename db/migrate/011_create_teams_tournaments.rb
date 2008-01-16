class CreateTeamsTournaments < ActiveRecord::Migration
  def self.up
    create_table :teams_tournaments, :id => false do |t|
      t.integer :team_id, :tournament_id
    end
    add_index :teams_tournaments, [:team_id]
    add_index :teams_tournaments, [:tournament_id]
  end

  def self.down
    drop_table :teams_tournaments
  end
end

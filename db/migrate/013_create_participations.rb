class CreateParticipations < ActiveRecord::Migration
  def self.up
    create_table :participations do |t|
      t.integer :team_id, :tournament_id, :null => false
    end
  end

  def self.down
    drop_table :participations
  end
end

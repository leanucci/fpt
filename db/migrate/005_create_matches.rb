class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer   :standing_id
      t.date      :played_date
      t.integer   :home_team_id
      t.integer   :away_team_id
      t.integer   :home_team_score
      t.integer   :away_team_score
    end
  end

  def self.down
    drop_table :matches
  end
end

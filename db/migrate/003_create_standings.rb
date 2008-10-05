class CreateStandings < ActiveRecord::Migration
  def self.up
    create_table :standings do |t|
      t.string    :name
      t.datetime  :scheduled_date
      t.integer   :tournament_id
    end
  end

  def self.down
    drop_table :standings
  end
end

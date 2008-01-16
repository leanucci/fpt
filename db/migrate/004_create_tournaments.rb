class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.integer  :t_type
      t.date     :season
      t.date     :start_date
      t.date     :finish_date
    end
  end

  def self.down
    drop_table :tournaments
  end
end

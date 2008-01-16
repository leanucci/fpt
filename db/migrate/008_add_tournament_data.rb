require 'active_record/fixtures'

class AddTournamentData < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "dev_data" )
    Fixtures.create_fixtures(directory, "tournaments" )

  end
  
  def self.down
    Tournament.delete_all
  end
  
end

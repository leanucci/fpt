require 'active_record/fixtures'

class AddTeamData < ActiveRecord::Migration

  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "dev_data" )
    Fixtures.create_fixtures(directory, "teams" )

  end
  
  def self.down
    Team.delete_all
  end
  
end


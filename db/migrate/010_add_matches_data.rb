require 'active_record/fixtures'

class AddMatchesData < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "dev_data" )
    Fixtures.create_fixtures(directory, "matches" )

  end
  
  def self.down
    Match.delete_all
  end
  
end

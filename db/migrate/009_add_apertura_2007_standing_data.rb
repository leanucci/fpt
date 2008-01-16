require 'active_record/fixtures'

class AddApertura2007StandingData < ActiveRecord::Migration
  def self.up
    down
    directory = File.join(File.dirname(__FILE__), "dev_data" )
    Fixtures.create_fixtures(directory, "standings" )

  end
  
  def self.down
    Standing.delete_all
  end
  
end

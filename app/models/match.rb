class Match < ActiveRecord::Base
  belongs_to  :standing
  
  belongs_to :away_team, :class_name => "Team", :foreign_key => "away_team_id"
  
  belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"
  
  
  def self.find_by_standing(standing_id)
    self.find(:all, :conditions => ["standing_id = ?", standing_id], 
                                     :include => [:standing, :away_team, :home_team],
                                     :order => "matches.played_date")
  end

end

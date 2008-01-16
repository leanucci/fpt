class MatchDetails < ActiveRecord::Base
  belongs_to  :match
  belongs_to  :home_team, :class_name => "Team"
  belongs_to  :away_team, :class_name => "Team"
end

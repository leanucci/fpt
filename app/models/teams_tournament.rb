class TeamsTournament < ActiveRecord::Base
  validates_uniqueness_of :team_id, 
                          :scope => :tournament_id, 
                          :message => "Team id #{team_id} is already assinged."
end

class Participation < ActiveRecord::Base

  belongs_to  :team
  belongs_to  :tournament
  
  validates_uniqueness_of :team_id, :scope => :tournament_id,
                          :message => "can only participate once per tournament"
end

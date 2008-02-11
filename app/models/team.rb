class Team < ActiveRecord::Base


  has_many :hosts,          :foreign_key => 'home_team_id', 
                            :class_name => 'Match'
                          
  has_many :away_teams,     :through => :hosts
  
  has_many :visits,         :foreign_key => 'away_team_id', 
                            :class_name => 'Match'
                          
  has_many :home_teams,     :through => :visits
  
  has_many :participations
  has_many :tournaments, :through => :participations
  
#  has_many :matches,        :finder_sql =>  'SELECT * FROM matches ' +
#                                            'WHERE matches.home_team_id = #{id} ' +
#                                            'OR matches.away_team_id = #{id} ' +
#                                            'ORDER BY matches.played_date'


  validates_uniqueness_of :short_name
  validates_uniqueness_of :complete_name
  validates_presence_of   :acronym_name, :short_name, :complete_name
  validates_length_of     :nickname_name, :in => 4..20, :allow_blank => true
  
  def self.safe_find_all
    @teams = Team.find(:all)
    return @teams ||= nil
  end

end

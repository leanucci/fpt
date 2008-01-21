class Tournament < ActiveRecord::Base
  
  has_and_belongs_to_many :teams
  has_many  :standings
  validate  :finish_date_ok?, :teams_in_tournament
  
  ##    
  # un tipo de torneo por temporada (apertura y clausura)
  
  validates_uniqueness_of     :t_type, :scope => :season, :message => "There can only be one tournament type for this season."
  validates_numericality_of   :t_type
  validates_length_of         :t_type, :is => 4
  validates_presence_of       :start_date, :finish_date, :t_type, :season
  
  
  def finish_date_ok?
    unless self.finish_date > self.start_date
      self.errors.add :finish_date, "Tournament has to end after it's Start Date."
      false
    else
      true
    end
  end
  
  def teams_in_tournament
    unless self.teams.count == 20
      self.errors.add :team_ids, "Tournament needs to have 20 teams."
      else
    end
  end
    
end


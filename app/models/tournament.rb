class Tournament < ActiveRecord::Base
  
  has_and_belongs_to_many :teams
  has_many  :standings

  before_save :check_teams_in_tournament 
  ##    
  # un tipo de torneo por temporada (apertura y clausura)
  
  validates_uniqueness_of     :t_type, :scope => :season, 
    :message => "There can only be one tournament type for this season."
    
  validates_presence_of       :start_date, :finish_date, :t_type, :season
  validates_numericality_of   :t_type
  validates_length_of         :t_type, :is => 4
  validate                    :finish_date_ok?, :dates_within_season?
 

  def finish_date_ok?
    if self.finish_date.nil? || self.start_date.nil?
      self.errors.add :finish_date, "Shouldnt be nil."
    elsif self.finish_date < self.start_date
      self.errors.add :finish_date, "Tournament has to end after it Starts."
      false
    else
      true
    end
  end
  
  def dates_within_season?
    if !self.finish_date.nil? && !self.season.nil?
      unless self.finish_date.year == self.season.year
        self.errors.add :finish_date, "The tournament should happen in the season's year (#{self.season.year})."
      end
      unless self.start_date.year == self.season.year
        self.errors.add :start_date, "The tournament should happen in the season's year (#{self.season.year})."      
      end
    end
  end
  
  def check_teams_in_tournament
    unless self.team_ids.size == 20
      self.errors.add :team_ids, "Tournament needs to have 20 teams."
      false
    else
      true
    end
  end
end


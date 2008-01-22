class Tournament < ActiveRecord::Base
  
  has_and_belongs_to_many :teams
  has_many  :standings, :dependent => :destroy

  ##    
  # un tipo de torneo por temporada (apertura y clausura)
  
  validates_uniqueness_of     :t_type, :scope => :season, 
    :message => "There can only be one tournament type for this season."
    
  validates_presence_of       :start_date, :finish_date, :t_type, :season
  validates_numericality_of   :t_type
  validates_length_of         :t_type, :is => 4
  validate                    :finish_date_ok?, :dates_within_season?
  
  after_save 'add_standings'

  def finish_date_ok?
    if self.finish_date.nil? || self.start_date.nil?
      self.errors.add :finish_date, "shouldnt be nil."
    elsif self.finish_date < self.start_date
      self.errors.add :finish_date, "should be after tournament start date."
      false
    else
      true
    end
  end
  
  def dates_within_season?
    if !self.finish_date.nil? && !self.season.nil?
      unless self.finish_date.year == self.season.year
        self.errors.add :finish_date, "should be in the season's year (#{self.season.year})."
      end
      unless self.start_date.year == self.season.year
        self.errors.add :start_date, "should be in the season's year (#{self.season.year})."      
      end
    end
  end
  
  def add_standings
    18.times do |i|
    fecha = "fecha #{ i + 1 }"
    if fecha[-2,1] == " "
      fecha.insert(-2,'0')
    end
      self.standings.create(
        :name => fecha,
        :scheduled_date => self.start_date,
        :tournament_id => self.id
      )
    end
  end
  
end


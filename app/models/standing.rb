class Standing < ActiveRecord::Base

  belongs_to  :tournament
  has_many    :matches, :dependent => :destroy

  validate :scheduled_date_too_early?, :scheduled_date_too_late?
  validates_uniqueness_of   :name, :scope => :tournament_id
  validates_presence_of     :tournament_id
  validates_uniqueness_of   :scheduled_date
  
  after_create :add_matches

  def self.find_with_tournament_matches_teams(id)
    self.find(id, :include => [ :tournament, :matches,
                              { :matches => [ :home_team, :away_team ] }],
                  :order   => "standings.scheduled_date" )
  end

  def self.find_with_tournament(id)
    self.find(id, :include => :tournament, :order => "standings.scheduled_date")
  end
  
  
private
  
  def scheduled_date_too_early?
    if self.scheduled_date < self.tournament.start_date
      self.errors.add :scheduled_date, "Standing can't be scheduled before tournament start date."
    end
    true
  end
     
  def scheduled_date_too_late?
    if self.scheduled_date > self.tournament.finish_date
      self.errors.add :scheduled_date, "Standing can't be scheduled after tournament end date."
    end
    true
  end
  
   def add_matches
    10.times do
      self.matches.create
    end
  end 
  
end

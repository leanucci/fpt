class Standing < ActiveRecord::Base

  belongs_to  :tournament
  has_many    :matches, :dependent => :destroy

  validate :scheduled_date_too_early?, :scheduled_date_too_late?
  
  validates_uniqueness_of   :name, :scope => :tournament_id
  validates_presence_of     :tournament_id
#  validates_uniqueness_of   :scheduled_date
  
  def self.find_by_tournament(tournament_id)
    self.find(:all, :conditions => ["tournament_id = ?", tournament_id], 
                                     :include => :tournament, 
                                     :order => "standings.scheduled_date")
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
  
end

class Tournament < ActiveRecord::Base

  has_many  :participations, :dependent => :destroy
  has_many  :teams, :through => :participations
  has_many  :standings, :dependent => :destroy, :order => "scheduled_date"

  ##
  # un tipo de torneo por temporada (apertura y clausura)

  validates_uniqueness_of     :t_type, :scope => :season,
    :message => "can have only one type per season"

  validates_presence_of       :start_date, :finish_date, :t_type, :season
  validates_numericality_of   :t_type
  validates_length_of         :t_type, :is => 4
  validate                    :finish_date_ok?, :dates_within_season?
  validate :too_many_teams? if :has_teams?



  after_create  :add_standings
#  after_save    :fulfill_teams if :has_teams?

  has_friendly_id :name_for_listing, :use_slug => true,
                                     :strip_diacritics => true,
                                     :max_length => 100

  NAMES = [{:id => 0, :name => "Apertura"},
           {:id => 1, :name => "Clausura"}]

  def name
    NAMES[t_type]
  end

  def name_for_listing
     name[:name] + " " + season.year.to_s
  end

  def finish_date_ok?
    if self.finish_date.nil? || self.start_date.nil?
      self.errors.add :finish_date, "shouldn't be nil"
    elsif self.finish_date < self.start_date
      self.errors.add :finish_date, "should be later than start date"
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
    19.times do |i|
    fecha = "fecha #{ i + 1 }"
    if fecha[-2,1] == " "
      fecha.insert(-2,'0')
    end
      self.standings.create(
        :name => fecha,
        :scheduled_date => self.start_date + i.days,
        :tournament_id => self.id
      )
    end
  end

#  def fulfill_teams
#    Participation.destroy_all(:tournament_id == self.id)
#    self.teams.each do |t|
#      Participation.create(:team_id => t, :tournament_id => self.id)
#    end
#  end

  def too_many_teams?
    if self.teams.size > 20
      self.errors.add :teams, "cant pass 20."
    end
  end

  def has_teams?
    !!self.team_ids
  end
end

module TournamentsHelper

  def get_team(id)
    Team.find(id)
  end

end

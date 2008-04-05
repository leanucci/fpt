module TournamentsHelper

  def get_tournament_type(tournament)
    if tournament.t_type == 1 
      return "Apertura"
    else
      return "Clausura"
    end
  end
  
  def get_team(id)
    Team.find(id)
  end
  
end

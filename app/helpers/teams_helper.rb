module TeamsHelper

  def name(team)
    if team == nil
      "--"
    else
      team.short_name.capitalize
    end 
  end
  
  def played(match)
    if match.played_date == nil
      "--"
    else
      match.played_date.to_formatted_s(:rfc822)
    end
  end
end

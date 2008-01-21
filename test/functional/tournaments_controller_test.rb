require File.dirname(__FILE__) + '/../test_helper'
require 'tournaments_controller'

# Re-raise errors caught by the controller.
class TournamentsController; def rescue_action(e) raise e end; end

class TournamentsControllerTest < ActionController::TestCase
  fixtures :tournaments, :standings, :matches, :teams
  
  def setup
    @controller = TournamentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @tournament = tournaments(:apertura07)
  end
  
  def test_should_get_index
    get :index
    assert_response :success
  end
  
  def test_should_get_new_with_teams
    get :new
    assert_response :success
    assert_not_nil assigns["teams"], "@teams should not be empty."
  end
  
 
  def test_should_validate_teams_participate_once_per_tournament
    flunk 'Complete me'
  end
  
  def test_should_offer_new_team_link_if_not_enough_teams
    flunk 'Complete me'    
  end
  
end

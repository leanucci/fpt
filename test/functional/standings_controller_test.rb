require File.dirname(__FILE__) + '/../test_helper'
require 'standings_controller'

# Re-raise errors caught by the controller.
class StandingsController; def rescue_action(e) raise e end; end

class StandingsControllerTest < ActionController::TestCase
  fixtures :tournaments, :standings, :matches, :teams
  
  def setup
    @controller = StandingsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  
  end
  
  def test_should_render_edit_link_for_emtpy_matches_on_standing_show
    get :show, {'id' => standings(:fecha2a07), 
                'tournament_id' => tournaments(:apertura07)}
    assert_response :success
  end
  
  def test_should_render_all_matches_on_standing_show
    get :show, {'id' => standings(:fecha1a07), 
                'tournament_id' => tournaments(:apertura07)}
    assert_response :success
  end
end

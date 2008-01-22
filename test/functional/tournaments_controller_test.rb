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

end

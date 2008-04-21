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
  
  def test_should_get_show
    get :show, :id => tournaments(:apertura07).id
    assert_response :success
  end
  
  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_tournament
    post :create, :tournament => {
                    "id" => 100,
                    "t_type" => 2,
                    "season" => "2007-01-01",
                    "start_date" => "2007-02-10",
                    "finish_date"  => "2007-06-15",
                    "team_ids"     => []}
    assert_redirected_to :controller => 'tournaments', :action => 'index'
  end
  
  def test_should_get_edit
    get :edit, :id => tournaments(:apertura07).id
    assert_response :success
  end
  
  def test_should_update
    get :edit, :id => tournaments(:apertura07).id
  end

end

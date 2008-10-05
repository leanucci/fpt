require File.dirname(__FILE__) + '/../test_helper'
class TournamentsControllerTest < ActionController::TestCase
  fixtures :tournaments, :standings, :matches, :teams, :slugs

  def setup
    @tournament = tournaments(:apertura07)
  end

  def test_should_get_index
    get :index
    assert_response :success
  end

  def test_should_get_show
    get :show, :id => @tournament.to_param
    assert_response :success
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_tournament
    post :create, :tournament => {
                    "t_type"       => 1,
                    "season"       => "2007-01-01",
                    "start_date"   => "2007-02-10",
                    "finish_date"  => "2007-06-15"}
    assert_redirected_to :controller => 'tournaments', :action => 'index'
  end

  def test_should_get_edit
    get :edit, :id => @tournament.to_param
    assert_response :success
  end
end

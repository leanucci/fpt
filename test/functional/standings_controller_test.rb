require File.dirname(__FILE__) + '/../test_helper'
class StandingsControllerTest < ActionController::TestCase
  fixtures :tournaments, :standings, :teams

  def test_should_render_edit_link_for_emtpy_matches_on_standing_show
    get :show, :id => standings(:fecha2a07).to_param,
               :tournament_id => tournaments(:apertura07).to_param
    assert_response :success
    assert_tag :tag => "div", :attributes => {:class => "msg"}
  end

  def test_should_render_all_matches_on_standing_show
    get :show, :id => standings(:fecha1a07).to_param,
               :tournament_id => tournaments(:apertura07).to_param
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => standings(:fecha1a07).to_param,
               :tournament_id => tournaments(:apertura07).to_param
    assert_response :success
  end
end

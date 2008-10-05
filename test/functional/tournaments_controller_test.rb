require File.dirname(__FILE__) + '/../test_helper'
class TournamentsControllerTest < ActionController::TestCase
  fixtures :tournaments, :standings, :matches, :teams, :slugs

  context "On GET to :index" do
    setup  do
      get :index
    end
    should_respond_with :success
    should_assign_to :tournaments
  end

  context "On GET to :show" do
    setup do
      @tournament = tournaments(:apertura07)
      get :show, :id => @tournament.to_param
    end
    should_respond_with :success
    should_assign_to :tournament
    should_assign_to :teams
  end

  context "On GET to :edit" do
    setup do
      @tournament = tournaments(:apertura07)
      get :edit, :id => @tournament.to_param
    end
    should_assign_to :tournament
    should_respond_with :success
    should_render_a_form
  end

  context "On GET to :new" do
    setup do
      get :new
    end

    should_assign_to :tournament
    should_render_a_form
    should_respond_with :success

    should "assign to new tournament" do
      assert assigns(:tournament).new_record?
    end
  end

  context "On POST to :create" do
    setup do
      @old_count = Tournament.count
    end

    context "with a valid tournament" do
      setup do
        post :create, :tournament => {:t_type       => 1,
                                      :season       => "2007-01-01",
                                      :start_date   => "2007-02-10",
                                      :finish_date  => "2007-06-15"}
      end
      should_redirect_to "tournaments_path"
      should_assign_to :tournament
      should_set_the_flash_to /successfully/
      should "actually create the tournament" do
        assert_equal @old_count + 1, Tournament.count
      end
    end

    context "with an invalid tournament" do
      setup do
        post :create, :tournament => {:t_type       => 1,
                                      :season       => "2007-01-01",
                                      :start_date   => "2008-02-10",
                                      :finish_date  => "2007-06-15"}
      end
      should_redirect_to "new_tournament_path"
      should_assign_to :tournament
      should_set_the_flash_to /foobar/
      should "not create the tournament" do
        assert_equal @old_count, Tournament.count
      end
    end
  end

  context "On DELETE to :destroy" do
    setup do
      @tournament = tournaments(:apertura07)
      @old_count = Tournament.count
      delete :destroy, :id => @tournament.to_param
    end
    should_assign_to :tournament
    should_redirect_to "tournaments_path"
    should_set_the_flash_to /kaboom/
    should "actually delete the tournament" do
      assert_equal @old_count - 1, Tournament.count
    end
  end

  context "On GET to :edit_teams" do
    setup do
      @tournament = tournaments(:apertura07)
      get :edit_teams, :id => @tournament.to_param
    end
    should_assign_to :tournament
    should_assign_to :teams
    should_assign_to :excluded
    should_assign_to :included
    should_respond_with :success

    should "fetch right collection of teams" do
      assert_equal assigns(:teams).size, Team.count
      assert_equal assigns(:included).size, assigns(:tournament).teams.size
      assert_equal assigns(:excluded).size, assigns(:teams).size - assigns(:tournament).teams.size
    end
  end
end

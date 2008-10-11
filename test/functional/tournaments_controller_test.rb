require File.dirname(__FILE__) + '/../test_helper'
class TournamentsControllerTest < ActionController::TestCase
  fixtures :tournaments, :standings, :matches, :teams, :slugs, :participations

  context "An existing tournament" do
    setup do
      @apertura = tournaments(:apertura07)
    end
    context "On GET to :show" do
      setup do
        get :show, :id => @apertura.to_param
      end
      should_respond_with :success
      should_assign_to :tournament
      should_assign_to :teams
    end

    context "On GET to :edit" do
      setup do
        get :edit, :id => @apertura.to_param
      end
      should_assign_to :tournament
      should_respond_with :success
      should_render_a_form
    end

    context "On PUT to :update" do
      context "with valid data" do
        setup do
          put :update, :id => @apertura.to_param,
                       :tournament => {:start_date => "2007-08-06"}
        end
        should_set_the_flash_to /Saved/
        should_redirect_to "tournaments_url"
        should_assign_to :tournament
        should "change the record" do
          assert assigns(:tournament).valid?
          assert_equal Tournament.find(@apertura.to_param).start_date.to_s, "2007-08-06"
        end
      end
      context "with invalid data" do
        setup do
          put :update, :id => @apertura.to_param,
                       :tournament => {:start_date => "2006-01-01"}
        end
        should_assign_to :tournament
        should_not_set_the_flash
        should_render_template :edit
        should_not_change "@apertura.start_date"
      end
    end

    context "On DELETE to :destroy" do
      setup do
        delete :destroy, :id => @apertura.to_param
      end
      should_assign_to :tournament
      should_redirect_to "tournaments_path"
      should_set_the_flash_to /kaboom/
      should_change "Tournament.count", :by => -1
      should "delete the tournament and its associates" do
        assert Participation.find_by_tournament_id(@apertura.to_param).nil?
      end
    end

    context "On GET to :edit_teams" do
      setup do
        get :edit_teams, :id => @apertura.to_param
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

    context "On PUT to :push_team" do
      context "to an incomplete tournament" do
        setup do
          put :push_team, :id => @apertura.to_param, :team => teams(:river).to_param
        end
        should_assign_to :team, :tournament
        should_change "@apertura.teams.count", :by => 1
        should "remove the team from excluded and move it to included" do
          assert_select_rjs :remove, "team_#{teams(:river).to_param}"
          assert_select_rjs :replace_html, "teamslist" do
            assert_select "DIV#team_#{teams(:river).to_param}.excluded_teams", false
            assert_select "DIV#team_#{teams(:river).to_param}.competitors"
          end
        end
      end
      context "to a complete tournament" do
        setup do
          @apertura.teams << Team.find(:all, :limit => 19, :offset => 1)
          put :push_team, :id => @apertura.to_param, :team => Team.last.to_param
        end
        should_assign_to :team, :tournament
        should_not_change "@apertura.teams"
        should "set the notice" do
          assert_select_rjs :replace_html, "notice"
          assert_select_rjs :show, "team_#{assigns(:team).to_param}"
        end
      end
    end

    context "On PUT to :remove_team" do
      setup do
        put :remove_team, :id => @apertura.to_param, :team => teams(:argentinos).to_param
      end
      should_assign_to :team, :tournament
      should_change "@apertura.teams.count", :by => -1
      should "remove the team from included and move it to excluded" do
        assert_select_rjs :replace_html, "excluded" do
          assert_select "DIV#team_#{teams(:argentinos).to_param}.competitors", false
          assert_select "DIV#team_#{teams(:argentinos).to_param}.excluded_teams"
        end
      end
    end
  end

  context "On GET to :index" do
    setup  do
      get :index
    end
    should_respond_with :success
    should_assign_to :tournaments
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
      should_change "Tournament.count", :by => 1
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
      should_not_change "Tournament.count"
    end
  end
end

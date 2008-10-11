require File.dirname(__FILE__) + '/../test_helper'
class TeamsControllerTest < ActionController::TestCase
  fixtures :teams, :slugs

  context "On GET to :index" do
    setup {get :index}
    should_assign_to :teams
    should_render_template :index
    should_respond_with :success
  end

  context "On GET to :show" do
    setup {get :show, :id => teams(:river).to_param}
    should_assign_to :team
    should_respond_with :success
    should_render_template :show
  end

  context "On GET to :new" do
    setup {get :new}
    should_respond_with :success
    should_render_template :new
    should_render_a_form
    should "assign to new team" do
      assert assigns(:team).new_record?
    end
  end

  context "On POST to :create" do
    context "with a valid team" do
      setup do
        post :create, :team => {:full_name => "Juventus Football Club",
                                :short_name => "Juventus",
                                :acronym_name => "JFC",
                                :nickname_name => "Vecchia Signora"}
      end
      should_change "Team.count", :by => 1
      should_assign_to :team
      should_set_the_flash_to /created/
      should "redirect to teams index without any errors" do
        assert_redirected_to teams_url
        assert assigns(:team).valid?
      end
    end

    context "with an invalid team" do
      setup {post :create, :team => {:full_name => "Incomplete FC"}}
      should_not_change "Team.count"
      should_assign_to :team
      should_not_set_the_flash
      should "redirect to new team page with errors" do
        assert_redirected_to new_team_path
        deny assigns(:team).valid?
      end
    end
  end

  context "On GET to :edit" do
    setup {get :edit, :id => teams(:river).to_param}
    should_assign_to :team
    should_respond_with :success
    should_render_template :edit
    should_render_a_form
  end

  context "On PUT to :update" do
    setup {@team = teams(:river)}
    context "with valid data" do
      setup {put :update, :id => @team.to_param, :team => {:short_name => "River"}}
      should_set_the_flash_to /Saved/
      should_redirect_to "teams_url"
      should "change the record" do
        assert_equal Team.find(@team.to_param).short_name, "River"
      end
    end
  end
end

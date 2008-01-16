require File.dirname(__FILE__) + '/../test_helper'
require 'standings_controller'

# Re-raise errors caught by the controller.
class StandingsController; def rescue_action(e) raise e end; end

class StandingsControllerTest < ActionController::TestCase
  fixtures :tournaments
  
  def setup
    @controller = StandingsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @standing   = standings(:fecha1a07)
  end
  
end

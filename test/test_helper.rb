ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  fixtures :tournaments
  ##
  # Variable de clase con los datos de un torneo valido (apertura 2007)

  @@tournament_default_values = {
    :id           => 1,
    :t_type       => 2,
    :season       => "2007-01-01",
    :start_date   => "2007-02-10",
    :finish_date  => "2007-06-15",
    :team_ids     => []
  }
    
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...

end

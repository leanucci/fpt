ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'test_help'
require File.expand_path(File.dirname(__FILE__) + '/helper_testcase')

require 'redgreen'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
 ##
  # Variable de clase con los datos de un torneo valido (apertura 2007)

  @@tournament_default_values = {
    :id           => 10,
    :t_type       => 1,
    :season       => "2005-01-01",
    :start_date   => "2005-02-10",
    :finish_date  => "2005-06-15"
  }


  def deny(condition, message='')
    assert !condition, message
  end

end

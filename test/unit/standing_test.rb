require File.dirname(__FILE__) + '/../test_helper'

class StandingTest < ActiveSupport::TestCase
  fixtures :tournaments, :standings 
  
  def test_should_not_allow_schedule_date_too_early
    tournament = tournaments(:apertura07)
    standing   = standings(:fecha1a07)
    standing.scheduled_date = "2006-12-10"
    assert !standing.valid?, "Date kaboom!"
    assert_equal standing.errors.on(:scheduled_date), "Standing can't be scheduled before tournament start date."
  end
  
  def test_should_not_allow_schedule_date_too_late
    tournament = tournaments(:apertura07)
    standing   = standings(:fecha1a07)
    standing.scheduled_date = "2007-12-10"
    assert !standing.valid?, "Date kaboom!"
    assert_equal standing.errors.on(:scheduled_date), "Standing can't be scheduled after tournament end date."
  end  
  
  def test_should_allow_schedule_inside_tournament_period
    tournament = tournaments(:apertura07)
    standing   = standings(:fecha1a07)
    assert standing.valid?, "Date kaboom!"
  end
  
  def test_should_create_10_matches_after_create
    standing = Standing.create({
      :tournament_id => tournaments(:clausura08).id,
      :name => "fecha 01",
      :scheduled_date => "2008-02-10",
      :id => 1
    })
    assert_equal 10, standing.matches.size
  end
  
end

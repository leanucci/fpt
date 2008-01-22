require File.dirname(__FILE__) + '/../test_helper'

class TournamentTest < ActiveSupport::TestCase
  fixtures :tournaments, :teams
  
  def test_should_create_valid_record
    old_count = Tournament.count
    tournament = Tournament.new(
      :id           => 1, 
      :t_type       => 2, 
      :season       => "2007-01-01", 
      :start_date   => "2007-02-10",
      :finish_date  => "2007-06-15" )
    tournament.teams = Team.find(:all, :limit => 20)
    assert tournament.valid?, "Tournament invalid."
    assert tournament.save, "Didnt save!"
    assert_equal Tournament.count, old_count + 1
  end
  
  def test_should_should_not_save_with_too_few_teams
    old_count = Tournament.count
    tournament = Tournament.new(
      :id           => 1, 
      :t_type       => 2, 
      :season       => "2007-01-01", 
      :start_date   => "2007-02-10",
      :finish_date  => "2007-06-15" )
    tournament.teams = Team.find(:all, :limit => 19)
    assert !tournament.save, "Didnt save!"
    assert_equal Tournament.count, old_count
  end
  
  def test_should_not_create_record_starting_after_end
    old_count = Tournament.count
    tournament = create( :finish_date => "2006-10-10" )
    assert !tournament.valid?, 
      "Sould not allow finish date later than start date." +
      "#{tournament.errors.on(:finish_date)}"
    assert_equal old_count, Tournament.count
  end
  
  def test_should_not_create_record_with_invalid_or_missing_fields
    tournament_1 = create( :season => nil )
    assert !tournament_1.valid?, "Should validate season not nil."
    
    tournament_2 = create( :season => "asd")
    assert !tournament_2.valid?, "Sould validate season as number."
    
    tournament_3 = create(:t_type => 1)
    tournament_4 = create(:t_type => 1)
    assert !tournament_3.valid?, "Should validate uniqueness of t type in season."
    assert !tournament_4.valid?, "Should validate uniqueness of t type in season."
  end
  
  def test_should_not_create_same_tournament_type_for_season
    tournament = create
    same_tournament = Tournament.new({
      :t_type       => 2,
      :season       => "2008-01-01",
      :start_date   => "2008-02-10",
      :finish_date  => "2008-06-15"  })
    assert !same_tournament.valid?, "Shouldnt save repeated tournament."
    assert_not_nil same_tournament.errors.on(:t_type), "Cant set two equal tournaments for a given season."
  end
  
  def test_should_accept_dates_in_order
    right_tournament = Tournament.new({
      :start_date  => "2008-01-01",
      :finish_date =>  "2008-01-02"
    })
    assert right_tournament.finish_date_ok?, "Shouldnt be any problems."
  end
  
  def test_should_not_accept_unordered_dates
    right_tournament = Tournament.new({
      :start_date  => "2008-01-02",
      :finish_date =>  "2008-01-01"
    })
    assert !right_tournament.finish_date_ok?, "Shouldnt be any problems."
  end 
  
  def test_should_save_tournament_with_20_teams
        
  end
  private
  
  def create(options={})
    Tournament.create(@@tournament_default_values.merge(options))
  end
 
end

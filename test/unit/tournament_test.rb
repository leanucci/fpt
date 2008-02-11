require File.dirname(__FILE__) + '/../test_helper'

class TournamentTest < ActiveSupport::TestCase
  fixtures :tournaments, :teams
  
  def test_should_create_valid_record
    old_count = Tournament.count
    @tournament = create(
      :id           => 1, 
      :t_type       => 2, 
      :season       => "2007-01-01", 
      :start_date   => "2007-02-10",
      :finish_date  => "2007-06-15" )
    assert @tournament.valid?, "Tournament invalid."
#    assert @tournament.save, "Didnt save!"
    assert_equal Tournament.count, old_count + 1, "Tournament didnt get saved."
  end
  
  def test_should_not_create_record_starting_after_end
    old_count = Tournament.count
    @tournament = create( :finish_date => "2006-10-10" )
    assert !@tournament.valid?, 
      "Sould not allow finish date later than start date." +
      "#{@tournament.errors.on(:finish_date)}"
    assert_equal old_count, Tournament.count, "Invalid tournament saved!"
  end
  
  def test_should_not_create_record_with_invalid_or_missing_fields
    old_count = Tournament.count
    @tournament_1 = create( :season => nil )
    assert !@tournament_1.valid?, "Should validate season not nil."
    
    @tournament_2 = create( :season => "asd")
    assert !@tournament_2.valid?, "Sould validate season as number."
    
    @tournament_3 = create(:t_type => 1)
    @tournament_4 = create(:t_type => 1)
    assert !@tournament_3.valid?, "Should validate uniqueness of t type in season."
    assert !@tournament_4.valid?, "Should validate uniqueness of t type in season."
    
    assert_equal old_count, Tournament.count, "None of the tournaments should've been saved."
  end
  
  def test_should_not_create_same_tournament_type_for_season
    @tournament = create
    @same_tournament = create({
      :t_type       => 2,
      :season       => "2008-01-01",
      :start_date   => "2008-02-10",
      :finish_date  => "2008-06-15"  })
    assert !@same_tournament.valid?, "Shouldnt save repeated tournament."
    assert !@same_tournament.errors.on(:t_type).empty?, "Cant set two equal tournaments for a given season."
  end
  
  def test_should_accept_dates_in_order
    old_count = Tournament.count
    @right_tournament = create({
      :start_date  => "2008-01-01",
      :finish_date =>  "2008-01-02"
    })
    assert @right_tournament.finish_date_ok?, "Shouldnt be any problems."
    assert_equal old_count, Tournament.count
  end
  
  def test_should_not_accept_unordered_dates
    @right_tournament = create({
      :start_date  => "2008-01-02",
      :finish_date =>  "2008-01-01"
    })
    assert !@right_tournament.finish_date_ok?, "Shouldnt be any problems."
  end
  
  def test_should_add_19_standings_after_save
    @tournament = create
    assert_equal 19, @tournament.standings.count, "should be 19."
  end
  
  def test_should_not_allow_over_20_teams_in_tournament
    @tournament = create
    old_count = @tournament.teams.size
    n = 0
    @tournament.team_ids = Array.new(21) {n += 2; n * 21}
    @tournament.save
    assert !@tournament.errors.empty?, "#{@tournament.errors.full_messages}"
    assert_equal 0, old_count, "zero expected."
  end
  
  def test_should_allow_upto_20_teams_in_tournament
    @tournament = create
    old_count = @tournament.teams.size
    n = 0
    @tournament.team_ids = Team.find(:all, :limit => 20).map {|t| t.id }
    @tournament.save
    assert @tournament.errors.empty?, "#{@tournament.errors.full_messages}"
    assert_not_equal old_count, @tournament.teams, "Fails 1"
    assert_equal 20, @tournament.teams.size, "Fails 2"
  end

  private
  
  def create(options={})
    Tournament.create(@@tournament_default_values.merge(options))
  end
 
end

# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081006225941) do

  create_table "matches", :force => true do |t|
    t.integer "standing_id"
    t.date    "played_date"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "home_team_score"
    t.integer "away_team_score"
  end

  add_index "matches", ["standing_id"], :name => "index_matches_on_standing_id"
  add_index "matches", ["home_team_id"], :name => "index_matches_on_home_team_id"
  add_index "matches", ["away_team_id"], :name => "index_matches_on_away_team_id"

  create_table "participations", :force => true do |t|
    t.integer "team_id",       :null => false
    t.integer "tournament_id", :null => false
  end

  add_index "participations", ["tournament_id", "team_id", "id"], :name => "index_participations_on_tournament_id_and_team_id_and_id", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slugs", :force => true do |t|
    t.string   "name",           :limit => 100
    t.string   "sluggable_type", :limit => 25
    t.integer  "sluggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slugs", ["name", "sluggable_type"], :name => "index_slugs_on_name_and_sluggable_type", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "standings", :force => true do |t|
    t.string   "name"
    t.datetime "scheduled_date"
    t.integer  "tournament_id"
  end

  add_index "standings", ["tournament_id"], :name => "index_standings_on_tournament_id"

  create_table "teams", :force => true do |t|
    t.string "full_name"
    t.string "short_name"
    t.string "acronym_name"
    t.string "nickname_name"
  end

  add_index "teams", ["short_name"], :name => "index_teams_on_short_name", :unique => true

  create_table "teams_tournaments", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "tournament_id"
  end

  add_index "teams_tournaments", ["team_id"], :name => "index_teams_tournaments_on_team_id"
  add_index "teams_tournaments", ["tournament_id"], :name => "index_teams_tournaments_on_tournament_id"

  create_table "tournaments", :force => true do |t|
    t.integer "t_type"
    t.date    "season"
    t.date    "start_date"
    t.date    "finish_date"
  end

end

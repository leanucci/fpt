class AddTeamsToTournaments < ActiveRecord::Migration
  def self.up
    @apertura = Tournament.last
    @teams    = Team.all(:limit => 20)
    @apertura.teams << @teams
    @apertura.save
  end

  def self.down
    @apertura = Tournament.last
    @apertura.teams.delete
  end
end

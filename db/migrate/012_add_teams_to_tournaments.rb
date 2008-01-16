class AddTeamsToTournaments < ActiveRecord::Migration
  def self.up
    @apertura = Tournament.find('1016639365')
    @teams    = Teams.find(:all)
    @apertura.teams << @teams
    @apertura.save!
  end

  def self.down
    @apertura = Tournament.find('1016639365')
    @apertura.teams.delete(:all)
  end
end

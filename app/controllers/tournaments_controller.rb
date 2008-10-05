class TournamentsController < ApplicationController
  before_filter :get_tournament, :except => [:index,
                                             :new,
                                             :create,
                                             :edit_teams,
                                             :push_team,
                                             :remove_team]

  def index
    @tournaments = Tournament.find(:all)
  end

  def show
    @tournament = Tournament.find(params[:id], :include => :standings,
                                  :order => "standings.scheduled_date")
    @teams = @tournament.teams
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      flash[:notice] = "Tournament successfully created."
      redirect_to tournaments_path
    else
      flash[:notice] = "Create foobar."
      redirect_to :action => 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Changes Saved."
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    if Tournament.find(params[:id]).destroy
      flash[:notice] = "Tournament went kaboom."
    else
      flash[:notice] = "Something went wrong."
    end
    redirect_to :action => 'index'
  end

  def edit_teams
    @tournament = Tournament.find(params[:id], :include => :teams)
    @teams = Team.find(:all, :order => "short_name")
    @excluded = @teams - @tournament.teams(:order => "short_name")
    @included = @tournament.teams()
  end

  def push_team
    @tournament = Tournament.find(params[:id], :include => :teams)
    @team = Team.find(params[:team])

    render :update do |page|
      if @tournament.teams.size == 20
        page.show "team_#{params[:team]}"
        page.replace_html "notice", :text => "Maximun of 20 teams reached. Remove a team first."
      else
        @tournament.teams << @team
        @included = @tournament.reload.teams
        @excluded = Team.find(:all) - @included
        page.remove "team_#{@team.to_param}"
        page.replace_html "teamslist", :partial => 'teams_included'
      end
    end
  end

  def remove_team
    @tournament = Tournament.find(params[:id], :include => :teams)
    @team = Team.find(params[:team])
    @tournament.teams.delete(@team) if @tournament.teams.include?(@team)
    @included = @tournament.teams
    @excluded = Team.find(:all, :order => "short_name") - @included
    render :update do |page|
      page.replace_html "excluded", :partial => 'teams_excluded'
      page.replace_html "notice", ""
    end
  end

  private
  def get_tournament
    @tournament = Tournament.find(params[:id])
  end
end

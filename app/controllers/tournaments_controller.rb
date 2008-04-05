class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.find(:all)
  end

  def show
  
#FIXME:  this doesnt eager load!!
    @tournament = Tournament.find(params[:id], :include => [:standings, :teams],
                                               :order   => "standings.name")
    @standings = @tournament.standings 
    @teams     = @tournament.teams

#    @standings = Standing.find( :all,
#                   :conditions => [ "tournament_id = ?", params[:id]],
#                   :order => "name ASC")
#    @tournament = @standings.first.tournament

  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    @tournament.team_ids = []
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
    @teams      = Team.find(:all)
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

#  def add_teams
#    params[:tournament][:team_ids] ||= []
#    @tournament = Tournament.find(params[:id])
#    @tournament.team_ids = params[:tournament][:team_ids]
#    if @tournament.save
#      redirect_to tournament_path(@tournament)
#      flash[:notice] = "Everythin ok."
#    else
#      redirect_to tournament_path(@tournament)
#    end
#  end
  
  def push_team
    @tournament = Tournament.find(params[:id], :include => :teams)
    @tournament.team_ids =  Array.[](@tournament.teams.map {|x| x.id}).flatten
    @tournament.team_ids << params[:team]
    if @tournament.save
      #@hide = Team.find(params[:team])
      @included = @tournament.reload.teams
      @excluded = Team.find(:all) - @included
      
      render :partial => 'teams_included'
    else
      #@hide = Team.find(params[:team])
      @included = @tournament.teams
      @excluded = Team.find(:all) - @included

       render :partial => 'teams_included'
    end
#    THIS WORKS!!  
#    @tournament = Tournament.find(params[:id])
#    @hide = Team.find(params[:team], :order => "short_name" )
#    @tournament.teams << @hide
#    @included = @tournament.teams(:order => "short_name")
#    @excluded = Team.find(:all, :order => "short_name") - @included
#    
#    render :partial => 'teams_included'
  end
  
  def remove_team
    @tournament = Tournament.find(params[:id])
    @tournament.participations.find_by_team_id(params[:team]).destroy
    @included = @tournament.teams
    @excluded = Team.find(:all, :order => "short_name") - @included
    
    render :partial => 'excluded_teams'

  end
end

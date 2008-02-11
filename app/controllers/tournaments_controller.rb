class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.find(:all)
  end

  def show
  
#FIXME:  this doesnt eager load!!
    @tournament = Tournament.find(params[:id],
      :include => [:standings, :teams],
      :order   => "standings.name")
    @standings = @tournament.standings 
    @teams     = @tournament.teams

#    @standings = Standing.find( :all,
#                   :conditions => [ "tournament_id = ?", params[:id]],
#                   :order => "name ASC")
#    @tournament = @standings.first.tournament

  end

  def new
    if @tournament.save!
      redirect_to tournament_path(@tournament)
      flash[:notice] = "Everythin ok."
    else
      flash.now[:notice] = "Save Fubar"
    end
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
    @teams      = Team.find(:all)
    @tournament = Tournament.find(params[:id])
  end

  def add_teams
    params[:tournament][:team_ids] ||= []
    @tournament = Tournament.find(params[:id])
    @tournament.team_ids = params[:tournament][:team_ids]
    if @tournament.save
      redirect_to tournament_path(@tournament)
      flash[:notice] = "Everythin ok."
    else
      redirect_to tournament_path(@tournament)
    end
  end
end

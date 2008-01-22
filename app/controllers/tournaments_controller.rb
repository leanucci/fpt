class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.find(:all)
  end

  def show
  
#FIXME:  this doesnt eager load!!
#FIXME:  @tournament = Tournament.find(params[:id],
#FIXME:    :include => :standings,
#FIXME:    :order   => "standings.scheduled_date")
#FIXME:  @standings = @tournament.standings 

    @standings = Standing.find_by_tournament(params[:id])
    @tournament = @standings.first.tournament

  end

  def new
    @teams = Team.safe_find_all
    if @teams.size < 20
      flash[:notice] = "Not enough teams for a tournament."          
      redirect_to new_team_path
    end   
    @tournament = Tournament.new
  end

  def create
    params[:tournament][:team_ids] ||= []
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      # @tournament.teams = params[:tournament][:team_ids]
      flash[:notice] = "Tournament successfully created."
      redirect_to tournaments_path
    else
      flash[:notice] = "Create foobar."
      redirect_to :action => 'new'
    end
  end
  
  def edit
    @tournament = Tournament.find(params[:id])
    @teams = Team.safe_find_all
  end
  
  def update    
    params[:tournament][:team_ids] ||= []
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
  
end

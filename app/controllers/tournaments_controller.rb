class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.find(:all)
  end

  def show
  
#FIXME:  this doesnt eager load!!
    @tournament = Tournament.find(params[:id],
      :include => :standings,
      :order   => "standings.name")
    @standings = @tournament.standings 

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
  
  def add_teams
  end
  
end

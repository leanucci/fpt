class TeamsController < ApplicationController

  def index
    @teams = Team.all(:order => "short_name")
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = "Team successfully created."
      redirect_to teams_path
    else
      redirect_to :action => 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = "Changes Saved."
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    if Team.find(params[:id]).destroy
      flash[:notice] = "Team went kaboom."
    else
      flash[:notice] = "Something went wrong."
    end
    redirect_to :action => 'index'
  end

  def sort_teams
    @teams = params[:list]
    render :partial => 'matches'
  end

end

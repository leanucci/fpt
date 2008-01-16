class StandingsController < ApplicationController

  def index
    @standings = Standing.find(:all)
  end

  def show
    @matches    = Match.find_by_standing(params[:id])
    @standing   = @matches.first.standing
    @tournament = @standing.tournament
  end

  def new
    @standing = Standing.new
  end

  def create
    @standing = Standing.new(params[:standing])
    if @standing.save
      flash[:notice] = "Standing successfully created."
      redirect_to standing_path(standing)
    else
      redirect_to :action => 'new'
    end
  end
  
  def edit
    @standing = Standing.find(params[:id])
  end
  
  def update
    @standing = Standing.find(params[:id])
    if @standing.update_attributes(params[:standing])
      flash[:notice] = "Changes Saved."
      redirect_to :action => 'index'
    else
      render :action => 'edit'  
    end
  end
  
  def destroy
    if Standing.find(params[:id]).destroy
      flash[:notice] = "Standing went kaboom."
    else
      flash[:notice] = "Something went wrong."
    end
    redirect_to :action => 'index'
  end
end

class StandingsController < ApplicationController
  def show
    @standing = Standing.find_with_tournament_matches_teams(params[:id])
    @tournament = @standing.tournament
  end

  def edit
    @standing = Standing.find_with_tournament_matches_teams(params[:id])
    @tournament = @standing.tournament
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
end

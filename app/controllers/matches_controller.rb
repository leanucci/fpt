class MatchesController < ApplicationController
  def index
    @matches = Match.find(:all)
  end

  def show
    tournament = Tournament.find(params[:tournament_id])
    standing = tournament.standings.find(params[:standing_id])
    @matches = standing.matches.find(:all)
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(params[:match])
    if @match.save
      flash[:notice] = "Match successfully created."
      redirect_to match_path(match)
    else
      redirect_to :action => 'new'
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      flash[:notice] = "Changes Saved."
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    if Match.find(params[:id]).destroy
      flash[:notice] = "Match went kaboom."
    else
      flash[:notice] = "Something went wrong."
    end
    redirect_to :action => 'index'
  end
end

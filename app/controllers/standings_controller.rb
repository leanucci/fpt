class StandingsController < ApplicationController

  def show
    @standing = Standing.find(params[:id], 
                  :include => [ :tournament, :matches,
                              { :matches => [ :home_team, :away_team ] }] )
  end

  def edit
    @standing = Standing.find(params[:id], :include => [ :tournament] )
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

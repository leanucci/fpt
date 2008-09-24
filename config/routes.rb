ActionController::Routing::Routes.draw do |map|

  map.resources :tournaments, :member=> {:edit_teams  => :get,
                                         :add_teams   => :put,
                                         :push_team   => :post,
                                         :remove_team => :post }

  map.resources :tournaments do |tournament|
    tournament.resources :standings do |standing|
      standing.resources :matches
    end
  end

  map.resources :teams, :member => "sort_teams"

  map.root :controller => "welcome"
end

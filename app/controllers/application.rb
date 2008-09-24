class ApplicationController < ActionController::Base
  layout "fpt"
  helper :all

  protect_from_forgery # :secret => 'd9077ab933889c5175cd8d83446e59ba'
end

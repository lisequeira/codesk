class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:search]
      @spaces = Space.search(params[:search])
    else
      @spaces = Space.all    
    end
  end

end

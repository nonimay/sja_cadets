class CadetsController < ApplicationController

  def index
    @cadets = Cadet.paginate(:page => params[:page])
  end
end

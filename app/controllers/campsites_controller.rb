class CampsitesController < ApplicationController
  def show
    @campsite = Campsite.find(params[:id])
  end
end

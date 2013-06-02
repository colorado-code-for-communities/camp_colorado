class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def show
    @search = Search.new
    if params[:search]
      @search.perform_with!(params[:search])
    end
  end
end

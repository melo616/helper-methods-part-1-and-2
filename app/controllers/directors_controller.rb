class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end

  def index
    @directors = Director.order(created_at: :desc)
    respond_to do |format|
      format.json do
        render json: @directors
      end

      format.html do
        render "directors/index"
      end
    end
  end


  
end

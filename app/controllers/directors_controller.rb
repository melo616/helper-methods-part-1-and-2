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

  def show
    @director = Director.find(params.fetch(:id))
  end

  def create
    director_attributes = params.require(:director).permit(:name, :dob, :bio)
    @director = Director.new(director_attributes)

    if @director.valid?
      @director.save
      redirect_to(directors_url, { :notice => "Director created successfully." })
    else
      render "directors/new"
    end
  end

end

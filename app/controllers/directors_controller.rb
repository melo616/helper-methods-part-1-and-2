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

  def edit
    @director = Director.find(params.fetch(:id))
  end

  def update
    director = Director.find(params.fetch(:id))
    director_attributes = params.require(:director).permit(:name, :dob, :bio)
    director.name = director_attributes["name"]
    director.dob = director_attributes["dob"]
    director.bio = director_attributes["bio"]

    if director.valid?
      director.save
      redirect_to("/directors", { :notice => "Director updated successfully."})
    else
      redirect_to("/directors", { :alert => "Director failed to update successfully." })
    end
  end

end

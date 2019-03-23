class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :upvote]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.upvotes = 0
    @restaurant.downvotes = 0

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def upvote
    @restaurant = Restaurant.find(params[:id])
    @restaurant.upvote
    @restaurant.save
    redirect_to @restaurant, notice: "#{@restaurant.name} upvoted"
  end

  def downvote
    @restaurant = Restaurant.find(params[:id])
    @restaurant.downvote
    @restaurant.save
    redirect_to @restaurant, notice: "#{@restaurant.name} downvoted"
  end

  def search
    if params[:search].blank?
      redirect_to(restaurants_index_path, notice: "Empty Search Field") and return
    else
      @parameter = "%" + params[:search].downcase + "%"
      @results = Restaurant.all.where("lower(name) LIKE :search OR lower(state) LIKE :search OR lower(city) LIKE :search OR lower(zipcode) LIKE :search", search: @parameter)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :streetaddress, :city, :state, :zipcode, :upvotes, :downvotes)
    end
end

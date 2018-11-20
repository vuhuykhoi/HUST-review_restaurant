class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.includes(:restaurant).references(:restaurants).all
    if params[:search].present?
      s = "%#{params[:search]}%"
      @reviews = @reviews.where("title LIKE ? OR restaurants.name LIKE ?", s, s)
    end

  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @comment = Comment.new
  end

  # GET /reviews/new


  # GET /reviews/1/edit
  def edit
    @review = Review.find_by id: params[:id]
    @foods = Food.all
    @restaurants = Restaurant.all

  end

  def new
    @review = Review.new
    @foods = Food.all
    @restaurants = Restaurant.all
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @foods = Food.all
    @restaurants = Restaurant.all
    @review = Review.new(
        title: params.require(:review).permit(:title)[:title],
        description: params.require(:review).permit(:description)[:description],
        user_id: current_user.id,
        restaurant_id: params.require(:review).permit(:restaurant_id)[:restaurant_id],
        score: params.require(:review).permit(:score)[:score]
      )
    @review.foods = Food.find( params.require(:review)[:food_id]) if params.require(:review)[:food_id]
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!! \n @review.save = #{@review.save}\n!!!!!!!!!!!!!!!!!!!!!!!!!!"

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      
      params.require(:review).permit(:title, :description, :user_id, :food_id, :restaurant_id, :score)
    end


end
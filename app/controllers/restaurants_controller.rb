class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy] #在開始執行action前 先做find_restaruant

  def index
    # render html: 'hello' #直接寫在這裡不好，通常寫在view裡
    #render({html: 'hello'}) #render方法,{html: 'hello'}是一個hash
    @restaurants = Restaurant.all.order(id: :desc)
  end

  def show
      @restaurant = Restaurant.find(params[:id])
      @restaurant = Restaurant.find(params[:title])
  
  end

  def new
     @restaurant = Restaurant.new
  end

  def create
    #寫入資料庫
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to restaurants_path #導向頁面到這
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant) #更新完後到剛更新完的那頁
    else
      render :edit
    end
  end

  def destroy
    if @restaurant.destroy
      redirect_to restaurants_path
    end
  end


  private
  def find_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
  end
  def restaurant_params
    params.require(:restaurant).permit(:title, :tel, :email, :address, :description) #過濾寫進資料庫的資料
  end
end
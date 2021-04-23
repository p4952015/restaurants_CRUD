class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:edit, :update, :destroy] #在開始執行action前 先做find_restaruant
  before_action :check_user, except: [:index, :show]

  def index
    # render html: 'hello' #直接寫在這裡不好，通常寫在view裡
    #render({html: 'hello'}) #render方法,{html: 'hello'}是一個hash
    # @restaurants = Restaurant.where(deleted_at: nil).all.order(id: :desc)
    @restaurants = Restaurant.all #available寫在model的scope
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
    @comment = @restaurant.comments.new
    @comments = @restaurant.comments.order(id: :desc)
  end

  def new
      @restaurant = Restaurant.new
  end

  def create
    #寫入資料庫
    # @restaurant = Restaurant.new(restaurant_params)
    # @restaurant.user_id = current_user.id
    @restaurant = current_user.restaurants.new(restaurant_params) #直接取代上面兩行

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
    # if @restaurant.update(deleted_at: Time.now) #將這段搬到model裡
    # end
    # 這段改寫成
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private
  def find_restaurant
    # 寫法1
    # @restaurant = Restaurant.find_by(
    #   id: params[:id], 
    #   user_id: current_user.id
    # )
    # 寫法2
    @restaurant = current_user.restaurants.find_by(id: params[:id])
  end
  
  def restaurant_params
    params.require(:restaurant).permit(:title, :tel, :email, :address, :description) #過濾寫進資料庫的資料
  end

end
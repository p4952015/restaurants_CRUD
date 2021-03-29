class RestaurantsController < ApplicationController
  def index
    # render html: 'hello' #直接寫在這裡不好，通常寫在view裡
    #render({html: 'hello'}) #render方法,{html: 'hello'}是一個hash
  end
end
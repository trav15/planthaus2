class PlantsController < ApplicationController
  get '/plants' do
    if logged_in?
      @user = current_user
      erb :'plants/index'
    else
      redirect to '/login'
    end
  end

  get '/plants/new' do
    if logged_in?
      erb :'plants/new'
    else
      redirect to '/login'
    end
  end

  post '/plants' do
    if logged_in?
      if params[:content] == ""
        redirect to "/plants/new"
      else
        @plant = current_user.plants.new(params)
        if @plant.save
          redirect to "/plants/#{@plant.id}"
        else
          redirect to "/plants/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/plants/:id' do
    if logged_in?
      @plant = Plant.find_by_id(params[:id])
      erb :'plants/show'
    else
      redirect to '/login'
    end
  end
end

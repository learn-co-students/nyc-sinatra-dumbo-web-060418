class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do

    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      @title = Title.create(name: params[:title][:name])
      FigureTitle.create(figure_id: @figure.id, title_id: @title.id)
    end
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(name: params[:landmark][:name], figure_id: @figure.id)
    end
    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["title"]["name"].empty?
      @title = Title.create(name: params[:title][:name])
      FigureTitle.create(figure_id: @figure.id, title_id: @title.id)
    end
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(name: params[:landmark][:name], figure_id: @figure.id)
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
  # post '/owners/:id' do
  #   @owner = Owner.find(params[:id])
  #   @owner.update(params["owner"]) #same as "owner_params" if done in private method
  #   if !params["pet"]["name"].empty?
  #     @owner.pets << Pet.create(name: params["pet"]["name"])
  #   end
  #   redirect to "owners/#{@owner.id}"
  # end

end

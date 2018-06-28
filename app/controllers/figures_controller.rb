class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    erb :"figures/new"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do

    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  post '/figures' do
    @figure = Figure.new(figure_params)
    @title = Title.find_or_create_by(name: params[:title][:name])
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @figure.titles << @title
    @figure.landmarks << @landmark
    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(figure_params)
    @title = Title.find_or_create_by(name: params[:title][:name])
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @figure.titles << @title
    @figure.landmarks << @landmark
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect to "/figures"
  end

  private

  def figure_params
    params[:figure]
  end

end

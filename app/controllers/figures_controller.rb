class FiguresController < ApplicationController
  get '/figures' do
    erb :"figures/index"
  end

  get '/figures/new' do
    erb :"figures/new"
  end

  get 'figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  post '/figures' do
    @figure = Figure.new(figure_params)
    # if something not empty then
    if !params[:title][:name].empty?
      @title = Title.new(params[:title])
      @title.save
      @figure.titles << @title
    end

    if !params[:landmark][:name].empty?
      @landmark = Landmark.new(name: params[:landmark][:name], figure_id: @figure.id)
      @landmark.save
      @figure.landmark << @landmark
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(figure_params)
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

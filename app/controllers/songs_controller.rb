require 'rack-flash'

class SongsController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end



  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(name:params[:artist][:name])
    @song.save
    #binding.pry
    flash[:message] = "Successfully created song."
    #binding.pry
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    if params[:song][:genre_ids].empty?
      params[:song][:genre_ids] = []
    end
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    # building the in case not ticking anything
    @song.artist = Artist.find_or_create_by(name:params[:artist][:name])
    @song.save
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

end

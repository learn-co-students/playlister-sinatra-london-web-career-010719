  require 'rack-flash'

class SongsController < ApplicationController

  enable :sessions
  use Rack::Flash


  get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :"/songs/new"
  end

  post '/songs' do
    artist = Artist.find_or_create_by(name: params[:artist][:name])
    song = Song.create(params[:song])
    song.update(artist_id: artist.id , genre_ids: params[:genres])

    flash[:message] = "Successfully created song."
    redirect "/songs/#{song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :"/songs/edit"
  end

  patch '/songs/:slug' do
    artist = Artist.find_or_create_by(name: params[:artist][:name])
    song = Song.find_by_slug(params[:slug])
    song.update(artist_id: artist.id , genre_ids: params[:genres], name: params[:song][:name])

    flash[:message] = "Successfully updated song."
    redirect "/songs/#{song.slug}"
  end

end

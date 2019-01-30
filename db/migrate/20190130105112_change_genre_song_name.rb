class ChangeGenreSongName < ActiveRecord::Migration
  def change
    rename_table :genre_songs, :song_genres
  end
end

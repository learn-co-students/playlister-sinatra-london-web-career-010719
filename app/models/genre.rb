class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres

  def artists
    @artists = []
    self.songs.each do |song|
      @artists << song.artist
    end
    return @artists.flatten
  end

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    name = slug.gsub(/[- ]/,"")
    Genre.select {|genre| genre.name.gsub(/[- ]/,"").downcase == name}.first

  end

end

class Song < ActiveRecord::Base
  has_many :song_genres
  belongs_to :artist
  has_many :genres, through: :song_genres


  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    name = slug.gsub(/[- ]/,"")
    Song.all.select {|song| song.name.gsub(/[- ]/,"").downcase == name}.first


  end

end

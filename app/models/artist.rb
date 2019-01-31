class Artist < ActiveRecord::Base
  has_many :songs

  def genres
    @genres = []
    self.songs.each do |song|
      @genres << song.genres
    end
    return @genres.flatten
  end

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    name = slug.gsub(/[- ]/,"")
    Artist.select{|artist| artist.name.gsub(/[- ]/,"").downcase == name}.first
  end

end

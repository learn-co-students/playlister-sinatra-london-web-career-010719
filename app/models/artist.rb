class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.gsub(" ", "-").downcase
  end


  def self.find_by_slug(input)
    self.all.find{|artist| artist.slug == input}
  end

end

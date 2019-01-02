require './lib/photograph'
require './lib/artist'
require 'csv'

class Curator

  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo_info)
    @photographs << Photograph.new(photo_info)
  end

  def add_artist(artist_info)
    @artists << Artist.new(artist_info)
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      id == artist.id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      id == photo.id
    end
  end

  def find_photographs_by_artist(artist)
    photographs.select do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.select do |artist|
      find_photographs_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    artists_from_country = @artists.select do |artist|
      artist.country == country
    end

    photos = artists_from_country.map do |artist|
      find_photographs_by_artist(artist)
    end
    photos.flatten
  end

  def load_photographs(file_path)
    CSV.foreach(file_path, headers:true, header_converters: :symbol) do |info|
      add_photograph(info)
    end
  end

  def load_artists(file_path)
    CSV.foreach(file_path, headers:true, header_converters: :symbol) do |info|
      add_artist(info)
    end
  end

  def photographs_taken_between(range)
    photos = @photographs.select do |photo|
      range.cover?(photo.year)
    end
    require 'pry'; binding.pry
  end



end

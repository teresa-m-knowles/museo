require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'minitest/autorun'
require 'minitest/pride'

class CuratorTest < Minitest::Test

  def test_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_it_starts_with_no_artists
    curator = Curator.new

    assert_equal [], curator.artists
  end

  def test_it_starts_with_no_photographs
    curator = Curator.new

    assert_equal [], curator.photographs
  end

  def test_it_can_add_photographs
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }
    curator = Curator.new

    photograph_1 = Photograph.new(photo_1)
    photograph_2 = Photograph.new(photo_2)

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_instance_of Photograph, curator.photographs.first
    assert_instance_of Photograph, curator.photographs[1]

    assert_equal 2, curator.photographs.count
    #fails since the array of photographs has a different objectID
    #assert_equal [photograph_1, photograph_2], curator.photographs
  end

  def test_it_can_get_photograph_attributes
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }
    curator = Curator.new

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    expected = "Rue Mouffetard, Paris (Boy with Bottles)"

    assert_equal expected, curator.photographs.first.name
  end

  def test_it_can_add_artists
    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
              }
    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
              }
    curator = Curator.new
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_instance_of Artist, curator.artists.first
    assert_instance_of Artist, curator.artists[1]

    assert_equal 2, curator.artists.count
  end

  def test_it_can_get_artists_attributes
    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
              }
    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
              }
    curator = Curator.new
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_instance_of Artist, curator.artists.first
    assert_equal "1908", curator.artists.first.born
    assert_equal "France", curator.artists.first.country
    assert_equal "2004", curator.artists.first.died
    assert_equal "1", curator.artists.first.id
    assert_equal "Henri Cartier-Bresson", curator.artists.first.name
  end

  def test_it_can_find_artists_by_id
    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
              }
    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
              }
    curator = Curator.new
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_instance_of Artist, curator.find_artist_by_id("1")
    assert_equal "Henri Cartier-Bresson", curator.find_artist_by_id("1").name
  end

  def test_it_can_find_photograph_by_id
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    found_photo = curator.find_photograph_by_id("2")

    assert_instance_of Photograph, found_photo
    assert_equal "2", found_photo.artist_id
    assert_equal "Moonrise, Hernandez", found_photo.name
  end

  def test_it_can_find_photoraphs_by_artist
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }

    photo_3 = {
                id: "3",
                name: "Identical Twins, Roselle, New Jersey",
                artist_id: "3",
                year: "1967"
              }

    photo_4 = {
                id: "4",
                name: "Child with Toy Hand Grenade in Central Park",
                artist_id: "3",
                year: "1962"
              }

    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
                }

    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
              }

    artist_3 =  {
                id: "3",
                name: "Diane Arbus",
                born: "1923",
                died: "1971",
                country: "United States"
              }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    diane_arbus = curator.find_artist_by_id("3")
    photos_by_arbus = curator.find_photographs_by_artist(diane_arbus)
    assert_instance_of Photograph, photos_by_arbus.first
    assert_equal 2, photos_by_arbus.count
    assert_equal "Identical Twins, Roselle, New Jersey", photos_by_arbus.first.name
    assert_equal "Child with Toy Hand Grenade in Central Park", photos_by_arbus[1].name
  end

  def test_it_can_return_array_of_artists_with_multiple_photographs
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }

    photo_3 = {
                id: "3",
                name: "Identical Twins, Roselle, New Jersey",
                artist_id: "3",
                year: "1967"
              }

    photo_4 = {
                id: "4",
                name: "Child with Toy Hand Grenade in Central Park",
                artist_id: "3",
                year: "1962"
              }

    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
                }

    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
              }

    artist_3 =  {
                id: "3",
                name: "Diane Arbus",
                born: "1923",
                died: "1971",
                country: "United States"
              }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    diane_arbus = curator.find_artist_by_id("3")
    artists = curator.artists_with_multiple_photographs

    assert_equal true, artists.all?{|artist| artist.class == Artist}
    assert_equal "Diane Arbus", curator.artists_with_multiple_photographs.first.name
    assert_equal 1, curator.artists_with_multiple_photographs.length
    assert_equal true, diane_arbus == curator.artists_with_multiple_photographs.first

  end

  def test_it_returns_an_array_of_photos_taken_by_an_artist_from_a_given_country
    photo_1 = {
                id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }
    photo_2 = {
                id: "2",
                name: "Moonrise, Hernandez",
                artist_id: "2",
                year: "1941"
              }

    photo_3 = {
                id: "3",
                name: "Identical Twins, Roselle, New Jersey",
                artist_id: "3",
                year: "1967"
              }

    photo_4 = {
                id: "4",
                name: "Child with Toy Hand Grenade in Central Park",
                artist_id: "3",
                year: "1962"
              }

    artist_1 = {
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
                }

    artist_2 = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
              }

    artist_3 =  {
                id: "3",
                name: "Diane Arbus",
                born: "1923",
                died: "1971",
                country: "United States"
              }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    photos_us = curator.photographs_taken_by_artist_from("United States")

    assert_equal true, photos_us.all?{|photo| photo.class == Photograph}
    assert_equal 3, photos_us.count
    assert_equal "Moonrise, Hernandez", photos_us.first.name
    assert_equal "Identical Twins, Roselle, New Jersey", photos_us[1].name
    assert_equal "Child with Toy Hand Grenade in Central Park", photos_us[2].name

    photos_arg = curator.photographs_taken_by_artist_from("Argentina")
    assert_equal [], photos_arg

  end

  def test_it_can_load_photographs_from_file
    skip
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_equal x, curator.photographs.count
  end

  def test_it_can_load_artists_from_file
    skip
    curator = Curator.new
    curator.load_artists('./data/artists.csv')

    assert_equal x, curator.artists.count
  end

  def test_it_can_return_array_of_photographs_taken_between_two_dates_using_files
    skip
    curator = Curator.new

    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')

    assert_equal x, curator.photographs_taken_between(1950..1965)

  end




end

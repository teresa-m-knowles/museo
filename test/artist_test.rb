require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'

class ArtistTest < MiniTest::Test

  def test_it_exists

  attributes = {
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
}

  artist = Artist.new(attributes)

  assert_instance_of Artist, artist
  end

  def test_it_has_id
    attributes = {
                  id: "2",
                  name: "Ansel Adams",
                  born: "1902",
                  died: "1984",
                  country: "United States"
                  }

    artist = Artist.new(attributes)

    assert_equal "2", artist.id
  end

  def test_it_has_name
    attributes = {
                  id: "2",
                  name: "Ansel Adams",
                  born: "1902",
                  died: "1984",
                  country: "United States"
                  }

    artist = Artist.new(attributes)

    assert_equal "Ansel Adams", artist.name
  end

  def test_it_has_a_year_of_birth
    attributes = {
                  id: "2",
                  name: "Ansel Adams",
                  born: "1902",
                  died: "1984",
                  country: "United States"
                  }

    artist = Artist.new(attributes)

    assert_equal "1902", artist.born
  end

  def test_it_has_a_year_of_death
    attributes = {
                  id: "2",
                  name: "Ansel Adams",
                  born: "1902",
                  died: "1984",
                  country: "United States"
                  }

    artist = Artist.new(attributes)

    assert_equal "1984", artist.died
  end

  def test_it_has_a_country_of_origin
    attributes = {
                  id: "2",
                  name: "Ansel Adams",
                  born: "1902",
                  died: "1984",
                  country: "United States"
                  }

    artist = Artist.new(attributes)

    assert_equal "United States", artist.country
  end
end

require 'pry'

class MusicLibraryController
  attr_reader :path

  def initialize(file_path = "./db/mp3s")
    @path = file_path
    importer_instance = MusicImporter.new(file_path)
    importer_instance.import
  end

  def call
    input = nil
    until input == "exit"
      puts "Welcome to your music library!"
      puts "What would you like to do?"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."

      input = gets.strip

      if input == 'list songs'
        list_songs
      elsif input == 'list artists'
        list_artists
      elsif input == 'list genres'
        list_genres
      elsif input == 'list artist'
        list_songs_by_artist
      elsif input == 'list genre'
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end
    end
  end

  def list_songs
    song_listings_array = Song.all.collect do |song|
      [["#{song.artist.name}"], ["#{song.name}"], ["#{song.genre.name}"]]
    end
    n = 0
    song_listings = song_listings_array.sort {|a, b| a[1] <=> b[1]}.each do |song_info|
      puts "#{n += 1}. #{song_info.join(" - ")}"
    end
    song_listings 
  end

  def list_artists
    artist_listings = Artist.all.collect do |artist|
      artist.name
    end
    n = 0
    artist_listings.sort.each do |artist|
      puts "#{n += 1}. #{artist}"
    end
  end

  def list_genres
    genre_listings = Genre.all.collect do |genre|
      genre.name
    end
    n = 0
    genre_listings.sort.each do |genre|
      puts "#{n += 1}. #{genre}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input)
      artist_instance = Artist.find_by_name(input)
      songs = artist_instance.songs.collect { |song| "#{song.name} - #{song.genre.name}"}
      n = 0
      songs.sort.each {|song_info| puts "#{n += 1}. #{song_info}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.find_by_name(input)
      genre_instance = Genre.find_by_name(input)
      songs = genre_instance.songs.collect { |song| "#{song.artist.name} - #{song.name}"}
      n = 0
      songs.sort {|a, b| a[1] <=> b[1]}.each {|song_info| puts "#{n += 1}. #{song_info}"}
    end
  end

  def play_song
    binding.pry
    puts "Which song number would you like to play?"
    list_songs
    input = gets.strip
    list_songs.detect do |song|
      input == 
  end

end

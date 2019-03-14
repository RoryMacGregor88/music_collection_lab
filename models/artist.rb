require 'pry'
require_relative('../db/sql_runner.rb')
require_relative('./album.rb')

class Artist

  attr_accessor :name, :id
  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists(name)
    VALUES($1)
    RETURNING *"
    values = [@name]
    returned_array = SqlRunner.run(sql, values)
    artist_hash = returned_array[0]
    id_string = artist_hash['id']
    @id = id_string.to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map {|hash| Artist.new(hash)}
  end

  def albums()
    sql = 'SELECT * FROM albums WHERE artist_id = $1'
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    return album_hashes.map {|hash| Album.new(hash)}
  end

  def update()
    sql = 'UPDATE artists SET name = $1 WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM artists WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    # binding.pry
    sql = 'SELECT * FROM albums WHERE id = $1'
    values = [id]
    artist_hash = SqlRunner.run(sql, values).first
    return Artist.new(artist_hash)
  end

end

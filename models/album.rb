require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Album

  attr_accessor :title, :genre, :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "
    INSERT INTO albums (title, genre, artist_id)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map {|hash| Album.new(hash)}
  end

  def artist()
    sql = 'SELECT * FROM artists WHERE id = $1'
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values).first
    return Artist.new(artist_hash)
  end

  def update()
    sql = 'UPDATE albums SET genre = $1 WHERE id = $2'
    values = [@genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM albums WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM albums'
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = 'SELECT * FROM albums WHERE id = $1'
    values = [id]
    album_hash = SqlRunner.run(sql, values).first
    return Album.new(album_hash)
  end

end

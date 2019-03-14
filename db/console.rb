require('pry-byebug')
require_relative('../models/album')
require_relative('../models/artist')

artist1 = Artist.new({'name' => 'Queen'})
artist2 = Artist.new({'name' => 'Blur'})
artist1.save()
artist2.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title'=> 'The Works',
  'genre'=> 'rock'
})
album1.save()

album2 = Album.new({
  'artist_id' => artist2.id,
  'title'=> 'Parklife',
  'genre'=> 'alt-rock'
})
album2.save()

album3 = Album.new({
  'artist_id' => artist1.id,
  'title'=> 'Hot Space',
  'genre'=> 'rock'
})
album3.save()

# Artist.delete_all()

# Album.delete_all()

# p Album.all()

# p Artist.all()

# p artist1.albums()

# p album2.artist()

# artist1.name = ('Freddie Mercury')
# artist1.update()
# p artist1

# album3.genre = 'funk'
# album3.update()
# p album3

# artist2.delete()

# album1.delete()

# Album.find(1)

Artist.find(56)

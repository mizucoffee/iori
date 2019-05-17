config = {}
if ENV['ENV'] == 'production'
  config = ENV['DATABASE_URL']
else
  config = {
    adapter: 'sqlite3',
    database: 'db/development.db'
  }
end

ActiveRecord::Base.establish_connection(config)

class User < ActiveRecord::Base
  has_many :reviews
  has_many :likes
  has_many :likes_reviews, through: :likes, source: :review
end

class Music < ActiveRecord::Base
  has_many :singers_musics
  has_many :composers_musics
  has_many :lyricists_musics
  has_many :arrangers_musics

  has_many :singers, through: :singers_musics, source: :artist
  has_many :composers, through: :composers_musics, source: :artist
  has_many :lyricists, through: :lyricists_musics, source: :artist
  has_many :arrangers, through: :arrangers_musics, source: :artist

  has_many :reviews
  belongs_to :genre
end

class Review < ActiveRecord::Base
  belongs_to :music
  belongs_to :user
  has_many :likes
  has_many :likes_users, through: :likes, source: :user
end

class Artist < ActiveRecord::Base
  has_many :singers_musics
  has_many :composers_musics
  has_many :lyricists_musics
  has_many :arrangers_musics

  has_many :singer_musics, through: :singers_musics, source: :music
  has_many :composer_musics, through: :composers_musics, source: :music
  has_many :lyricist_musics, through: :lyricists_musics, source: :music
  has_many :arranger_musics, through: :lyricists_musics, source: :music
end

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
end

class Genre < ActiveRecord::Base
  has_many :musics
end

class SingersMusic < ActiveRecord::Base
  belongs_to :music
  belongs_to :artist
end

class ComposersMusic < ActiveRecord::Base
  belongs_to :music
  belongs_to :artist
end

class LyricistsMusic < ActiveRecord::Base
  belongs_to :music
  belongs_to :artist
end

class ArrangersMusic < ActiveRecord::Base
  belongs_to :music
  belongs_to :artist
end

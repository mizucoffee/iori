db_config = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(db_config[ENV['ENV'] || 'development'])

class User < ActiveRecord::Base
  has_many :reviews
  has_many :likes
end

class Music < ActiveRecord::Base
  has_many :singers_musics
  has_many :composers_musics
  has_many :lyricists_musics
  has_many :reviews
  belongs_to :genre
end

class Review < ActiveRecord::Base
  belongs_to :music
  belongs_to :user
end

class Artist < ActiveRecord::Base
  has_many :singers_musics
  has_many :composers_musics
  has_many :lyricists_musics
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

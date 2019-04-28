db_config = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(db_config['development'])

class User < ActiveRecord::Base
  has_many :reviews
  has_many :likes
end

class Song < ActiveRecord::Base
  has_many :singers_songs
  has_many :composers_songs
  has_many :lyricists_songs
  has_many :reviews
  belongs_to :genre
end

class Review < ActiveRecord::Base
  belongs_to :song
  belongs_to :user
end

class Artist < ActiveRecord::Base
end

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
end

class Genre < ActiveRecord::Base
  has_many :genres
end

class SingersSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :artist
end

class ComposersSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :artist
end

class LyricistsSong < ActiveRecord::Base
  belongs_to :song
  belongs_to :artist
end

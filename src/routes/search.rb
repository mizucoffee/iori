# frozen_string_literal: true

# /search Router
class SearchRouter < Base
  get '/' do
    @q = params[:q]
    @tab = params[:tab]
    @musics = @q.blank? ? [] : Music.where('name like ?', "%#{@q}%")
    @artists = @q.blank? ? [] : Artist.where('name like ?', "%#{@q}%")
    @users = @q.blank? ? [] : User.where('name like ?', "%#{@q}%")
    erb :'routes/search/root'
  end

  get '/advanced' do
    erb :'routes/search/advanced/root'
  end

  post '/advanced/review' do
    @hue = params[:hue].to_i
    @light = params[:light] == '1'
    redirect '/search/advanced' if @hue.blank?
    if @hue >= 10 && @hue <= 350
      @reviews = Review.where(hue: (@hue - 10)..(@hue + 10), light: @light)
    elsif @hue < 10
      @reviews = Review.where('(hue between 0 and ?) or (hue between ? and 360)', @hue + 10, 360 + @hue - 10)
    elsif @hue > 350
      @reviews = Review.where('(hue between ? and 360) or (hue between 0 and ?)', @hue - 10, @hue + 10 - 360)
    end
    erb :'routes/search/advanced/review'
  end

  post '/advanced/music' do
    @song = params[:song]
    @singer = params[:singer]
    @composer = params[:composer]
    @lyricist = params[:lyricist]
    @arranger = params[:arranger]
    @genre = params[:genre]

    redirect '/search/advanced' if @song.blank? && @singer.blank? && @composer.blank? && @lyricist.blank? && @arranger.blank?
    @musics = Music.includes(:singers, :composers, :lyricists, :arrangers)
                   .where('musics.name like ? and artists.name like ?
                     and composers_musics.name like ?
                     and lyricists_musics.name like ?
                     and arrangers_musics.name like ?
                     and musics.genre_id like ?',
                          "%#{@song}%", "%#{@singer}%", "%#{@composer}%", "%#{@lyricist}%", "%#{@arranger}%", @genre == '0' ? '%' : "%#{@genre}")
                   .references(:singers, :composers, :lyricists, :arrangers).map{|e| Music.find(e.id) }
    erb :'routes/search/advanced/music'
  end

  post '/advanced/user' do
    @id = params[:id]
    @name = params[:name]
    redirect '/search/advanced' if @name.blank? && @id.blank?
    @users = User.where('name like ?', "%#{@name}%")
    @users = @users.where(screen_name: @id) unless @id.blank?
    erb :'routes/search/advanced/user'
  end
end

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
    @type = params[:type]
    case @type
    when 'review' then
      color = params[:color]
      if color.blank?
        @type = ''
        erb :'routes/search/advanced'
      end
    when 'music' then
      song = params[:song]
      singer = params[:singer]
      composer = params[:composer]
      lyricist = params[:lyricist]
      arranger = params[:arranger]
      if song.blank? && singer.blank? && composer.blank? && lyricist.blank? && arranger.blank?
        @type = ''
        erb :'routes/search/advanced'
      end
      @musics = Music.includes(:singers, :composers, :lyricists, :arrangers)
                     .where('musics.name like ? and artists.name like ?
                       and composers_musics.name like ?
                       and lyricists_musics.name like ?
                       and arrangers_musics.name like ?',
                            "%#{song}%",
                            "%#{singer}%",
                            "%#{composer}%",
                            "%#{lyricist}%",
                            "%#{arranger}%")
                     .references(:singers, :composers, :lyricists, :arrangers)
    when 'user' then
      name = params[:name]
      id = params[:id]
      if name.blank? && id.blank?
        @type = ''
        erb :'routes/search/advanced'
      end
    else
      # Error
    end
    erb :'routes/search/advanced'
  end
end

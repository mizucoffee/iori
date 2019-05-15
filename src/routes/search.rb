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
    when 'music' then
      @musics = Music.includes(:singers, :composers, :lyricists, :arrangers)
                     .where('musics.name like ? and artists.name like ?
                       and composers_musics.name like ?
                       and lyricists_musics.name like ?
                       and arrangers_musics.name like ?',
                            "%#{params[:song]}%",
                            "%#{params[:singer]}%",
                            "%#{params[:composer]}%",
                            "%#{params[:lyricist]}%",
                            "%#{params[:arranger]}%")
                     .references(:singers, :composers, :lyricists, :arrangers)
    when 'user' then
      name = params[:name]
      id = params[:id]
    else
      # Error
    end
    erb :'routes/search/advanced'
  end
end

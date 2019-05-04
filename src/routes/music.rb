# /music Router
class MusicRouter < Base
  get '/' do
    @q = params[:q]
    pp params[:q]
    @musics = @q.blank? ? [] : Music.where('name like ?', "%#{params[:q]}%")
    erb :music_search
  end
end

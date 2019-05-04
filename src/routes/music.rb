# /music Router
class MusicRouter < Base
  get '/' do
    @q = params[:q]
    @musics = @q.blank? ? [] : Music.where('name like ?', "%#{@q}%")
    erb :'routes/music/root'
  end

  get '/:music_id' do
    @music = Music.find(params[:music_id])
    # 404処理等
    erb :'routes/music/music'
  end
end

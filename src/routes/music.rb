# /music Router
class MusicRouter < Base
  get '/:music_id' do
    @music = Music.find(params[:music_id])
    # 404処理等
    erb :'routes/music/music'
  end
end

# /music Router
class MusicRouter < Base
  get '/:music_id' do
    @music = Music.find_by(id: params[:music_id])
    error 404 if @music.blank?
    erb :'routes/music/music'
  end
end

# /artist Router
class ArtistRouter < Base
  get '/:artist_id' do
    @artist = Artist.find_by(id: params[:artist_id])
    error 404 if @artist.blank?
    erb :'routes/artist/artist'
  end
end

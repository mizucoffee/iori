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
end

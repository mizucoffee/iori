# /api Router
class ApiRouter < Base
  get '/' do
    'Iori!'
  end

  get '/music/search' do
    Music.where('name like ?', "%#{params[:q]}%").to_json
  end

  post '/music' do
    Music.create()
  end

  get '/artist' do
    Artist.all.to_json
  end

  get '/artist/search' do
    Artist.where('name like ?', "%#{params[:q]}%").to_json
  end

  post '/artist' do
    # 重複チェック / 同姓同名
    Artist.create(name: params[:q])
    '{ok: true}'
  end

  get '/genre' do
    Genre.all.to_json
  end

  get '/genre/search' do
    Genre.where('name like ?', "%#{params[:q]}%").to_json
  end
end

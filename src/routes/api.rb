# /api Router
class ApiRouter < Base
  get '/' do
    'Iori!'
  end

  get '/music/search' do
    Music.where('name like ?', "%#{params[:q]}%").to_json
  end

  post '/music' do
    music = Music.create({ name: params[:name], genre: Genre.find(params[:genre])})

    params[:singer].split(',').each do |s|
      music.singers << Artist.find(s)
    end

    params[:composer].split(',').each do |s|
      music.composers << Artist.find(s)
    end

    params[:lyricist].split(',').each do |s|
      music.lyricists << Artist.find(s)
    end

    params[:arranger].split(',').each do |s|
      music.arrangers << Artist.find(s)
    end

    music.save
  end

  get '/artist' do
    Artist.all.to_json
  end

  get '/artist/search' do
    Artist.where('name like ?', "%#{params[:q]}%").to_json
  end

  post '/artist' do
    # 重複チェック / 同姓同名
    Artist.create(name: params[:name])
    '{ok: true}'
  end

  get '/genre' do
    Genre.all.to_json
  end

  get '/genre/search' do
    Genre.where('name like ?', "%#{params[:q]}%").to_json
  end
end

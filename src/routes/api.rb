# /api Router
class ApiRouter < Base
  get '/' do
    'Iori!'
  end

  get '/music/search' do
    Music.where('name like ?', "%#{params[:q]}%").to_json
  end

  post '/music' do
    music = Music.create({ name: params[:name], genre_id: params[:genre] })
    params[:singer].split(',').each do |s|
      SingersMusic.create({ music_id: music.id, singers_id: s })
    end

    params[:composer].split(',').each do |s|
      ComposersMusic.create({ music_id: music.id, composers_id: s })
    end

    params[:lyricist].split(',').each do |s|
      LyricistsMusic.create({ music_id: music.id, lyricists_id: s })
    end

    params[:arranger].split(',').each do |s|
      ArrangersMusic.create({ music_id: music.id, arrangers_id: s }) 
    end
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

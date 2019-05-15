# /api Router
class ApiRouter < Base
  post '/music' do
    music = Music.create({ name: params[:name], genre: Genre.find(params[:genre]) })

    artist(music, params[:singer], 'singer')
    artist(music, params[:composer], 'composer')
    artist(music, params[:lyricist], 'lyricist')
    artist(music, params[:arranger], 'arranger')

    music.save
    music.to_json
  end

  get '/music/search' do
    Music.where('name like ?', "%#{params[:q]}%").to_json
  end

  get '/artist/search' do
    Artist.where('name like ?', "%#{params[:q]}%").to_json
  end

  get '/genre/search' do
    Genre.where('name like ?', "%#{params[:q]}%").to_json
  end

  def artist(music, artist, target)
    artist.split(',').each do |s|
      music.send("#{target}s=", music.send("#{target}s") << Artist.find(s))
    end
  end

  post '/artist' do
    Artist.create(name: params[:name])
    '{ok: true}'
  end
end

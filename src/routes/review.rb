# /review Router
class ReviewRouter < Base
  get '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?
    @type = 'confirm'

    erb :'routes/review/new'
  end

  post '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?

    hash = {
      title: params[:title],
      body: params[:body],
      music: Music.find(params[:music]),
      hue: params[:hue],
      light: params[:light] == '1',
      review_type: 0,
      user: @me
    }
    @review = Struct.new(*hash.keys).new(*hash.values)
    @type = 'confirm'

    erb :'routes/review/new'
  end

  post '/confirm' do
    redirect '/account/login?next=/review/new' if @me.nil?

    hash = {
      title: params[:title],
      body: params[:body],
      music: Music.find(params[:music]),
      hue: params[:hue],
      light: params[:light] == '1',
      review_type: 0,
      user: @me
    }
    @review = Struct.new(*(hash.keys)).new(*(hash.values))

    erb :'routes/review/confirm'
  end

  post '/make' do
    redirect '/account/login?next=/review/new' if @me.nil?
    r = Review.create(
      title: params[:title],
      body: params[:body],
      music: Music.find(params[:music]),
      hue: params[:hue],
      light: params[:light] == '1',
      review_type: params[:review_type],
      user: @me
    )
    @me.reviews << r
    @me.save
    redirect "/@#{@twitter.screen_name}/#{r.id}"
  end

  post '/update' do
    redirect '/account/login?next=/' if @me.nil?
    r = Review.find(params[:id])

    r.title = params[:title]
    r.body = params[:body]
    r.music = Music.find(params[:music])
    r.hue = params[:hue]
    r.light = params[:light] == '1'
    r.review_type = 0

    r.save

    redirect "/@#{@twitter.screen_name}/#{r.id}"
  end
end

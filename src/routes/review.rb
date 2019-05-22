# frozen_string_literal: true

# /review Router
class ReviewRouter < Base
  get '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?
    @type = 'confirm'
    unless session[:title].blank?
      hash = {
        title: session[:title],
        body: session[:body],
        hue: session[:hue],
        light: session[:light] == '1',
        review_type: 0,
        user: @me
      }
      hash['music'] = Music.find(session[:music]) unless session[:music].blank?
      @review = Struct.new(*hash.keys).new(*hash.values)
      @error = true
      @type = session[:type] if session[:type]
    end

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

    if params[:title].blank? || params[:body].blank? || params[:music].blank? || params[:hue].blank? || params[:light].blank?
      session[:title] = params[:title]
      session[:body] = params[:body]
      session[:hue] = params[:hue]
      session[:light] = params[:light]
      session[:music] = params[:music]
      redirect '/review/new'
    end

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

    erb :'routes/review/confirm'
  end

  post '/make' do
    redirect '/account/login?next=/review/new' if @me.nil?

    if params[:title].blank? || params[:body].blank? || params[:music].blank? || params[:hue].blank? || params[:light].blank?
      session[:title] = params[:title]
      session[:body] = params[:body]
      session[:hue] = params[:hue]
      session[:light] = params[:light]
      session[:music] = params[:music]
      redirect '/review/new'
    end

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

    if params[:title].blank? || params[:body].blank? || params[:music].blank? || params[:hue].blank? || params[:light].blank?
      session[:title] = params[:title]
      session[:body] = params[:body]
      session[:hue] = params[:hue]
      session[:light] = params[:light]
      session[:music] = params[:music]
      session[:type] = 'edit'
      redirect '/review/new'
    end

    r = Review.find(params[:id])
    if r.user.twitter_id == @me.twitter_id
      r.title = params[:title]
      r.body = params[:body]
      r.music = Music.find(params[:music])
      r.hue = params[:hue]
      r.light = params[:light] == '1'
      r.review_type = 0
      r.save

      redirect "/@#{@twitter.screen_name}/#{r.id}"
    else
      error 403
    end
  end
end

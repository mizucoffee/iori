# /review Router
class ReviewRouter < Base
  get '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?
    @genre = Genre.all
    erb :'routes/review/new'
  end

  post '/new' do
    redirect '/account/login?next=/review/new' if @me.nil?
    r = Review.create({
      title: params[:title],
      body: params[:body],
      music: Music.find(params[:music]),
      hue: params[:hue],
      light: params[:light] == '1',
      review_type: 0,
      user: @me
    })
    @me.reviews << r
    @me.save
    redirect "/@#{@twitter.screen_name}/#{r.id}"
  end
end

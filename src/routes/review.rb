# /review Router
class ReviewRouter < Base
  get '/new' do
    @genre = Genre.all
    redirect '/account/login?next=/review/new' if @me.nil?
    erb :review_new
  end
end

# /user Router
class UserRouter < Base
  get '/' do
    @q = params[:q] || ''
    if @q.start_with?('@')
      @users = @q.blank? ? [] : User.where(screen_name: @q.gsub(/^./, ''))
      redirect "/@#{@users[0].screen_name}" if @users.length == 1
    else
      @users = @q.blank? ? [] : User.where('name like ?', "%#{@q}%")
    end
    erb :'routes/user/root'
  end
end

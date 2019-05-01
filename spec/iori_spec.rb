RSpec.describe 'ルーティング', type: :request do
  it "get '/'" do
    get '/'
    expect(last_response).to be_ok
  end
end

RSpec.describe 'リダイレクト', type: :request do
  it "get '/'" do
    get '/account/login/'
    expect(last_response.status == 301)
    follow_redirect!
    expect(last_response).to be_ok
  end
end

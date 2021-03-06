RSpec.describe 'ルーティング', type: :request do
  it "get '/'" do
    get '/'
    expect(last_response).to be_ok
  end
  it "get '/search'" do
    get '/search'
    expect(last_response).to be_ok
  end
end

RSpec.describe 'リダイレクト', type: :request do
  it "get '/account/login/'" do
    get '/account/login/'
    expect(last_response.status == 301)
    follow_redirect!
    expect(last_response).to be_ok
  end
end

RSpec.describe 'アクセス権限', type: :request do
  it "get '/review/new'" do
    get '/review/new'
    expect(last_response.status == 301)
    follow_redirect!
    expect(last_response).to be_ok
  end
end

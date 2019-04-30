require 'bundler/setup'
Bundler.require :default, :development, :test
Dotenv.load
SimpleCov.start
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require './src/app'

# Test
class IoriTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::URLMap.new(Iori::ROUTES)
  end

  def test_root
    get '/'
    assert last_response.ok?
  end
end

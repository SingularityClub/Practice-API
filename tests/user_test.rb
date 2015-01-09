require "#{__dir__}/../config/environment"
require 'minitest/spec'

describe PracticeAPI::ArticleApi do
  include Rack::Test::Methods

  def app
    PracticeAPI::ArticleApi
  end

  describe PracticeAPI::ArticleApi do
    describe "GET /api/statuses/public_timeline" do
      it "returns an empty array of statuses" do
        get "/api/#statuses/public_timeline"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq []
      end
    end
    describe "GET /api/statuses/:id" do
      it "returns a status by id" do
        status = Status.create!
        get "/api/statuses/#{status.id}"
        expect(last_response.body).to eq status.to_json
      end
    end
  end
end
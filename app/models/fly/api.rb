require "net/http"

module Fly
  class API
    attr_reader :api_token

    def initialize(api_token:, host: "127.0.0.1")
      @api_token = api_token
      @host = host
    end

    def post(path, hash)
      Net::HTTP.post api(path), hash.to_json, headers
    end

    def get(path)
      Net::HTTP.get api(path), headers
    end

    # Yikes, this is the real API. Everything else is the Machines API.
    def graphql(payload)
      Net::HTTP.post URI("https://api.fly.io/graphql"), payload, headers
    end

    def machine
      Machine.new(api: self)
    end

    private
      def headers
        {
            "Authorization" => "Bearer #{@api_token}",
            "Content-Type" => "application/json",
            "Accept" => "application/json"
        }
      end

      def api(path="/")
        URI("http://#{@host}:4280").tap do |url|
          url.path = path
        end
      end
  end
end

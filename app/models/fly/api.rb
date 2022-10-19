require "net/http"
require "uri"

module Fly
  class API
    attr_reader :api_token
    HOST = "api.machines.dev".freeze

    def initialize(api_token: , host: HOST)
      @api_token = api_token
      @host = host
    end

    def post(path, hash)
      pp [
        :post,
        api(path).to_s,
        :hash,
        hash,
        :json,
        hash.to_json
      ]
      Net::HTTP.post(api(path), hash.to_json, headers).tap do |response|
        pp [
          :response,
          response,
          response.body
        ]
      end
    end

    def get(path)
      Net::HTTP.get api(path), headers
    end

    # Yikes, this is the real API. Everything else is the Machines API.
    def graphql(query)
      response = Net::HTTP.post URI("https://api.fly.io/graphql"), { query: query }.to_json, headers
      JSON.parse(response.body)
    end

    def application(name: Fly.env_app_name)
      Application.new(api: self, name: name)
    end

    private
      def headers
        raise "FLY_AUTH_TOKEN required" if @api_token.nil?

        {
            "Authorization" => "Bearer #{@api_token}",
            "Content-Type" => "application/json",
            "Accept" => "application/json"
        }
      end

      def api(path="/")
        URI("https://#{@host}").tap do |url|
          url.path = path
        end
      end
  end
end

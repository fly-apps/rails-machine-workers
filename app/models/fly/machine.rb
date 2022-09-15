require "net/http"
require "uri"

module Fly
  class Machine

    def initialize(api:)
      @api = api
    end

    def current_image_ref(app=self.class.env_app_name)
      response = @api.graphql %{
        query {
          app(name: "#{app}") {
            currentRelease {
              imageRef
            }
          }
        }
      }

      JSON.parse(response.body).dig("data", "app", "currentRelease", "imageRef")
    end

    def self.env_app_name
      ENV["FLY_APP_NAME"]
    end
  end
end

require "net/http"
require "uri"

module Fly
  class Machine

    def initialize(api:)
      @api = api
    end

    def current_image_ref(app)
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
  end
end

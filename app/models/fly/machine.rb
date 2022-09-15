require "net/http"
require "uri"

module Fly
  class Machine

    def initialize(api:)
      @api = api
    end

    def current_image_ref(app)
      @api.graphql %{
        query {
          app(name: "#{app}") {
            currentRelease {
              imageRef
            }
          }
        }
      }
    end
  end
end

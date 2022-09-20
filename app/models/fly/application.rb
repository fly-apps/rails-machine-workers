module Fly
  class Application
    attr_accessor :name, :api

    def initialize(name:, api:)
      @name = name
      @api = api
    end

    def image_ref
      api.graphql(%{
        query {
          app(name: "#{name}") {
            currentRelease {
              imageRef
            }
          }
        }
      }).dig("data", "app", "currentRelease", "imageRef")
    end
  end
end

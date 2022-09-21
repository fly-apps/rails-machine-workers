module Fly
  class Application
    attr_accessor :name, :api

    def initialize(name:, api:)
      @name = name
      @api = api
    end

    def machine
      Machine.new(app: self)
    end

    # Doocker image of the currently running application
    def image_ref
      machine_image_ref || query_image_ref
    end

    private

    # Newer containers are injecting this variable, which
    # means we can skip the lookup.
    def machine_image_ref
      ENV["FLY_IMAGE_REF"]
    end

    # Some environments don't have the `FLY_IMAGE_REF` variable
    # so we have to look it up via an internal, undocumented, GraphQL
    # that if you try using it, it will one day break.
    def query_image_ref
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

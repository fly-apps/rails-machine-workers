module Fly
  class Release
    def self.current_image_ref
      # TODO: Wire up this GraphQL request
      # curl 'https://api.fly.io/graphql' -H 'Accept-Encoding: gzip, deflate, br' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Connection: keep-alive' -H 'DNT: 1' -H 'Origin: https://api.fly.io' -H 'Fly-GraphQL-Client: playground' --data-binary '{"query":"query {\n  app(name: \"gessler-family-website\") {\n    currentRelease {\n      imageRef\n    }\n  }\n}"}' --compressed
      "registry.fly.io/fly-rails-playground:deployment-01GCYNXMNQTF6EFFJYHGVB42KY"
    end
  end
end



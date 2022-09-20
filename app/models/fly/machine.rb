require "net/http"
require "uri"

module Fly
  class Machine

    def initialize(api:, app:)
      @api = api
      @app = app
    end
  end
end

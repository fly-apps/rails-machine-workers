require "net/http"
require "uri"

module Fly
  class Machine

    def initialize(api:)
      @api = api
    end
  end
end

require "net/http"
require "uri"

module Fly
  class Machine

    def initialize(app:)
      @api = app.api
      @app = app
    end

    def image_ref
      @app.image_ref
    end

    # If we're running the application from a Nomad, we need to create a
    # new Fly application that works with machines.
    def worker_app_name
      "#{@app.name}-workers"
    end

    # Runs a Fly machine. When the machine is done running, that's it! You
    # don't need to worry about deleting it later.
    def run(name: nil, region: nil, config: {})
      @api.post "/v1/apps/#{worker_app_name}/machines", {
        name: name,
        region: region,
        config: config
      }
    end

    def fork(**config)
      # Merge the currently running environment into the configuration of the
      # machine that we're going to launch. This includes secrets, so make sure
      # you're running your code in the machine and you trust the image. If you
      # don't trust the runtime, say for a CI environment, you'd leave the `ENV`
      # vars out, so you should probably use the `run` method above.
      config.fetch(:env, {}).merge! ENV
      # We're going to boot the image of the currently running application.
      config[:image] = image_ref
      run config: config
    end
  end
end

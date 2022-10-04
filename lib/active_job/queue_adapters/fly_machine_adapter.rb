# frozen_string_literal: true

module ActiveJob
  module QueueAdapters
    # == Fly Machine adapter for Active Job
    #
    # Boot VMs in 500ms, run a Rails background job, and shuts it down when it's all done.
    #
    #   Rails.application.config.active_job.queue_adapter = :fly_machine
    class FlyMachineAdapter
      def enqueue(job) # :nodoc:
        Fly.app.machine.fork init: {
          cmd: [
            "/app/bin/rails",
            "runner",
            "ActiveJob::Base.deserialize(#{job.serialize}).run"
          ]
        }
      end

      def enqueue_at(*) # :nodoc:
        raise NotImplementedError, "Does not yet support queueing background jobs in the future"
      end
    end
  end
end

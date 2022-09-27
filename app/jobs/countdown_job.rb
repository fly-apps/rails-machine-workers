class CountdownJob < ApplicationJob
  queue_as :default

  def perform(seconds: 0)
    (seconds..0).each do |second|
      puts second
      sleep 1
    end
    puts "Blastoff!"
  end
end

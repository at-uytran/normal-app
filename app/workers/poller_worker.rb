class PollerWorker
  # include Sidekiq::Worker
  # include Sidekiq::Status::Worker

  include Shoryuken::Worker
  shoryuken_options queue: 'video_render_queue', auto_delete: true

  def perform
    poller_stats = POLLER.poll({max_number_of_messages: 10 }) do |messages|
      messages.each do |message|
        ProcessWorker.perform_async message
        puts "Message body: #{message.body}"
      end
    end
  end
end

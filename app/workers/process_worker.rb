class ProcessWorker
  # include Sidekiq::Worker
  # include Sidekiq::Status::Worker
  include Shoryuken::Worker
  shoryuken_options queue: 'video_render_queue', auto_delete: true, body_parser: :json

  def perform sqs_msg, messages
    logger = Logger.new(Rails.root.join("log", "process_worker.log"))
    logger.info(messages)
    sleep 10
  end
end

class Video::ConvertStreamWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  STORE_FOLDER = "./stream_folder"

  def perform file_path, file_name, video_id
    video = Video.find_by id: video_id
    store_folder = STORE_FOLDER
    VideoToHlsConvertService.new(file_path, file_name, store_folder).execute
    video.done!
    Video::UploadHlsToS3Worker.perform_async("")
  rescue StandardError => e
    video.failed!
    logger = Logger.new Rails.root.join("log", "convert_stream_worker.log")
    logger.info "===> ConvertStreamWorker error: #{e}"
  end
end

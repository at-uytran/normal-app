class Video::DownloadVideoWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  DOWNLOAD_DIR = "./download_videos"
  AVAILABLE_EXTENSIONS = ["mp4", "mov"]

  def perform video_id
    retries ||= 0
    video = Video.find_by id: video_id
    if !file_exists_on_s3? video.file.path
      raise "File not exists"
    end
    url = video.file.url
    file_name = video&.file&.identifier
    return if file_name.blank?
    file_extension = file_name.split(".").last
    return if AVAILABLE_EXTENSIONS.exclude?(file_extension&.downcase)
    save_path = [DOWNLOAD_DIR, "video_#{video.id}.#{file_extension}"].join("/")
    download_link = video.file&.url
    status, file_path = download_video(save_path, download_link)
    puts status
    puts file_path
    return unless status
    job_id = Video::ConvertStreamWorker.perform_async(file_path, "video_#{video.id}.#{file_extension}", video.id)
    video.update_attributes!(job_id: job_id, process_status: :processing)
  rescue StandardError => e
    puts e
    sleep 3
    retry if (retries += 1) < 5
  end

  private
  def download_video save_path, download_link
    open(save_path, "wb") do |file|
      file << open(download_link).read
      file.close
    end
    [true, save_path]
  rescue StandardError => e
    puts e
    [false, nil]
  end

  def file_exists_on_s3? s3_path
    s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"])
    s3.bucket(ENV["BUCKET_NAME"]).object(s3_path).exists?
  end
end

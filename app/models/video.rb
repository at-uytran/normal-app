class Video < ApplicationRecord
  include VideoDecorator
  mount_uploader :file, VideoUploader

  after_create_commit :convert_to_stream_format

  enum process_status: {init: 0, processing: 1, done: 2, failed: 3, uploading: 4, uploaded: 5}

  private
  def convert_to_stream_format
    # binding.pry
    Video::DownloadVideoWorker.perform_async self.id
    # Video::HlsConvertWorker.perform_async(self.class.name, self.id, :file)
  end
end

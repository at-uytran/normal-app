class Video < ApplicationRecord
  include VideoDecorator
  mount_uploader :file, VideoUploader

  after_create :convert_to_stream_format

  enum process_status: {init: 0, processing: 1, done: 2, failed: 3}

  private
  def convert_to_stream_format
    Video::HlsConvertWorker.perform_async(self.class.name, self.id, :file)
  end
end

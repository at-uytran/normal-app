class Video::HlsConvertWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  STORE_FOLDER = Settings.hls_store_folder

  def perform model_name, object_id, field
    object = model_name.classify.constantize.find_by(id: object_id)
    object.processing!
    file_name = object.send("#{field}_identifier")
    store_folder = STORE_FOLDER
    original_file_path = [Rails.root, "public#{object.send("#{:file}_url").to_s}"].join("/")
    service = Mp4ToHlsConvertService.new(original_file_path, file_name, store_folder).execute
  end
end

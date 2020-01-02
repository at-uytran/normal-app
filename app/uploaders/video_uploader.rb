class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer

  storage :file

  def filename
    if original_filename
      formatted_name = original_filename.gsub(/[^0-9A-Za-z]/, '-').gsub(model.file.file.extension, "")
      "#{formatted_name}.#{model.file.file.extension}"
    end
  end 

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process thumbnail: [{format: "png", quality: 10, size: 512, logger: Rails.logger}]
    def full_filename for_file
      png_name for_file, version_name
    end
  end

  def png_name for_file, version_name
    %Q{#{version_name}_video_#{model.id}.png}
  end
end

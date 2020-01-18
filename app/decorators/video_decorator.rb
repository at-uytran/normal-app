module VideoDecorator
  HLS_STORE_FOLDER = Settings.hls_store_folder
  HLS_BASE_HTTP_LINK = Settings.hls_http_link

  def video_data
    {
      hls: {
        link: hls_playlist_file,
        thumb: thumb_url
      }
    }
  end

  def hls_playlist_file
    HLS_STORE_FOLDER + "/" + name_in_hls(:m3u8)
  end

  def name_in_hls extension
    self.send("#{:file}_identifier").gsub(self.file.file.extension, extension.to_s)
  end

  def hls_link
    HLS_BASE_HTTP_LINK + name_in_hls(:m3u8)
  end

  def thumb_url
    path = self.file_url :thumb
    [Rails.root.to_s, "public" + path].join("/")
  end
end

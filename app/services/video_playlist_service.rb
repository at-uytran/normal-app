class VideoPlaylistService
  def initialize video_id
    @video = Video.find_by(id: video_id)
    @signer = Aws::S3::Presigner.new
    @folder = "hls"
  end

  def generate_playlist
    master_playlist_data = @video.job_id
    playlist = M3u8::Playlist.read(master_playlist_data)
    playlist.items.each do |item|
      item_link = @signer.presigned_url(:get_object, bucket: ENV["BUCKET_NAME"], key: [@folder, item.segment.to_s].join("/"), expires_in: 3600)
      item.segment = item_link
    end
    playlist.to_s
  end
end

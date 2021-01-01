class User::BaseController < ApplicationController
  def download_video
    data = open(Video.last.file_url) 
    send_data data.read, filename: "NAME_YOU_WANT.mp4", type: "video/mp4", stream: 'true', buffer_size: '4096'
  end

  def get_m3u8
    playlist = VideoPlaylistService.new(2).generate_playlist
    # render json: {data: playlist}
    # application/vnd.apple.mpegurl
    # application/x-hls
    send_data playlist.to_s, type: "application/vnd.apple.mpegurl", disposition: 'inline'
  end

  private
  def authenticate_user!
  end

  def sign_in object
    binding.pry
  end
end

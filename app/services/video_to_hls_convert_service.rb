class VideoToHlsConvertService
  def initialize original_file_path, file_name, store_folder
    @original_file_path = original_file_path
    @file_name = file_name
    @store_folder = store_folder
    file_extension = @file_name&.split(".")&.last
    return if file_extension.blank?
    @result_file_name = @file_name.gsub(file_extension, "m3u8")
  end

  def execute
    puts "executing VideoToHlsConvertService"
    result_file_path = [@store_folder, @result_file_name].join("/")
    command_line = get_exec_command(@original_file_path, result_file_path)
    exec_command(command_line)
  end

  def get_exec_command original_file_path, result_file_path
    video_resolution = get_video_resolution(original_file_path)
    command_arr = [
      "ffmpeg",
      "-i",
      original_file_path,
      '-flags',
      '-global_header',
      "-profile:v",
      "baseline",
      "-level",
      "3.0",
      "-s",
      video_resolution,
      "-start_number",
      "0",
      "-hls_time",
      "10",
      "-hls_list_size",
      "0",
      "-f",
      "hls",
      result_file_path
    ]
    command_arr.join(" ")
  end

  def get_video_resolution original_file_path
    command_arr = [
      "ffprobe",
      "-v",
      "error",
      "-select_streams",
      "v:0",
      "-show_entries",
      "stream=width,height",
      "-of",
      "csv=s=x:p=0",
      original_file_path
    ]
    command_line = command_arr.join(" ")
    stdout, stderr, status = Open3.capture3(*command_line)
    stdout.strip
  end

  def exec_command command_line
    puts "executing: #{command_line}"
    system(command_line.to_s)
  end
end

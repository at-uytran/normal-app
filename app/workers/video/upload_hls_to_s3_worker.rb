class Video::UploadHlsToS3Worker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform path
    s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"])
    path = "./stream_folder"
    list_files = Dir.glob("./stream_folder/*").map{|s| File.basename(s)}
    list_files.each do |file_name|
      obj = s3.bucket(ENV["BUCKET_NAME"]).object("hls/#{file_name}")
      File.open([path, file_name].join("/"), "rb") do |file|
        puts "Processing hls/#{file_name}"
        obj.put(body: file)
      end
    end
  end
end

# s3 = Aws::S3::Resource.new
# path = 'photos/deepak_file/aws_test.txt'
# s3.bucket('storagy-teen-dev-us').object(path).upload_file(./tmp/aws_test.txt)

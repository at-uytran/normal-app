signer = Aws::S3::Presigner.new
signer.presigned_url(:get_object, bucket: ENV["BUCKET_NAME"], key: "hls/SampleVideo-1280x720-10mb-#{i}.ts", expires_in: 5.minutes.to_i)

class GenerateHlsUrlService
  
end

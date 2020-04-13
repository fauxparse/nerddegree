AWS.config(
  access_key_id: ENV['S3_KEY'],
  secret_access_key: ENV['S3_SECRET']
)

S3_BUCKET = AWS::S3.new.buckets[ENV['S3_BUCKET']]

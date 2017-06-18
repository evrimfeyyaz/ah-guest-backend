Paperclip::Attachment.default_options.update(
  url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
  hash_secret: Rails.application.secrets.secret_key_base,
  default_url: ''
)

if Rails.env.production?
  Paperclip::Attachment.default_options.merge!(storage: :s3,
                                               s3_protocol: :https,
                                               s3_credentials: {
                                                 access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                 secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                 s3_region: ENV['AWS_REGION'],
                                                 bucket: ENV['S3_BUCKET_NAME']
                                               })
end
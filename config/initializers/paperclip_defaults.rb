Paperclip::Attachment.default_options.update(
  url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
  hash_secret: Rails.application.secrets.secret_key_base,
  default_url: ''
)

if Rails.env.production?
  Paperclip::Attachment.default_options.merge!(storage: :s3,
                                               s3_credentials: {
                                                 access_key_id: Rails.application.secrets.aws_access_key_id,
                                                 secret_access_key: Rails.application.secrets.aws_secret_access_key
                                               },
                                               bucket: 'dry-dawn-66033-2')
end
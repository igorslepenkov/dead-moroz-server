CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider: 'Google',
    google_storage_access_key_id: Rails.application.credentials.google_cloud[:access_key],
    google_storage_secret_access_key: Rails.application.credentials.google_cloud[:secret]
    # can optionally use google_json_key_location if using an actual file;
  }
  config.fog_directory = Rails.application.credentials.google_cloud[:bucket]
  config.fog_public = nil
end

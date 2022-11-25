CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider: 'Google',
    google_project: Rails.application.credentials.google_cloud[:project_id],
    google_json_key_string: Rails.application.credentials.google_cloud[:json_key_string].to_json
  }
  config.fog_directory = Rails.application.credentials.google_cloud[:bucket]
  config.fog_public = nil
end

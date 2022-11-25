class FailureApp < Devise::FailureApp
  def respond
    request.media_type == 'application/json' || request.media_type == 'multipart/form-data' ? api_unauthorized_request : super
  end

  private

  def api_unauthorized_request
    self.status = :unauthorized
    self.content_type = 'json'
    self.response_body = { message: 'Unauthorized' }.to_json
  end
end

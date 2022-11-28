class FailureApp < Devise::FailureApp
  def respond
    api_unauthorized_request
  end

  private

  def api_unauthorized_request
    self.status = :unauthorized
    self.content_type = 'json'
    self.response_body = { message: 'Unauthorized' }.to_json
  end
end

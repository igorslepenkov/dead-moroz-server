class FailureApp < Devise::FailureApp
  def respond
    if http_auth?
      http_auth
    elsif warden_options[:recall]
      recall
    else
      something_got_wrong_response
    end
  end

  private

  def something_got_wrong_response
    response_obj = { message: 'Something got wrong' }

    self.status = :bad_request
    self.response_body = response_obj.to_json
    self.content_type = request.format.to_s
  end
end

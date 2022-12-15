module ChildProfilesServices
  class TranslationService < ApplicationService
    URL = URI('https://rapid-translate-multi-traduction.p.rapidapi.com/t')

    def initialize(profile)
      @profile = profile
    end

    def call
      initialize_request

      http = Net::HTTP.new(URL.host, URL.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = http.request(@req)

      translated_fields_array = JSON.parse(response.body)

      {
        country: translated_fields_array[0][0],
        city: translated_fields_array[1][0],
        hobbies: translated_fields_array[2][0],
        past_year_description: translated_fields_array[3][0],
        good_deeds: translated_fields_array[4][0]
      }
    end

    private

    def initialize_request
      @req = Net::HTTP::Post.new(URL)
      @req['content-type'] = 'application/json'
      @req['X-RapidAPI-Key'] = Rails.application.credentials.rapid_api.translation[:key]
      @req['X-RapidAPI-Host'] = Rails.application.credentials.rapid_api.translation[:host]
      @req.body = {
        from: 'auto',
        to: 'fi',
        e: '',
        q: [@profile.country, @profile.city, @profile.hobbies, @profile.past_year_description, @profile.good_deeds]
      }.to_json
    end
  end
end

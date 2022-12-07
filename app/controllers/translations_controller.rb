class TranslationsController < ApplicationController
  before_action :set_child_profile, only: :show

  def show
    cached_translation = Rails.cache.read("translated_profile/#{@child_profile.id}")

    if cached_translation[:created_at] && cached_translation[:created_at] > @child_profile.updated_at
      translated_fields = cached_translation[:translated_fields]
    else
      translated_fields = ChildProfilesServices::TranslationService.call(@child_profile)
      Rails.cache.write("translated_profile/#{@child_profile.id}", { translated_fields:, created_at: Time.now })
    end
    render json: translated_fields, status: :ok
  end

  private

  def set_child_profile
    @child_profile = ChildProfile.find(params[:child_profile_id])
  end
end

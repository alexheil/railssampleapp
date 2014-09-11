class StaticPagesController < ApplicationController
  before_action do
   @user = current_user
  end

  def home
  end

  def faq
  end

  def contact
  end

  def privacy_policy
  end

  def terms_of_service
  end

  def copyright_info
  end
end

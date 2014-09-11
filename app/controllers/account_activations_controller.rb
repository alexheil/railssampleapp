class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(activation_token: params[:id])
    if user
      user.activate
      flash[:success] = "Account activated!"
      log_in user
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end

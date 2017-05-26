class UsersController < ApplicationController
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    end
  end

  private
  def user_params
    params.require(:user).permit(:current_invoice_id)
  end
end

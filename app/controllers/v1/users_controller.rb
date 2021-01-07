class V1::UsersController < ApplicationController
  def register
    user = User.new(user_params)
    if user.valid? && user.save
      render json: user,
        adapter: :json,
        status: 201 and return
    end
    render json: user.errors, status: 400
  end

  def login
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by(email: email)
    is_valid = user && user.valid_password?(password)
    unless is_valid
      render json: {
        status: 'error',
        message: 'Invalid credentials'
      }, status: 400 and return
    end
    return render json: user,
      status: 200
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end

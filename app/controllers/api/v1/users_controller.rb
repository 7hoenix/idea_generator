class Api::V1::UsersController < ApplicationController
  def show
    @user = current_user
    # @user = UserPresenter.new(current_user)
  end
end

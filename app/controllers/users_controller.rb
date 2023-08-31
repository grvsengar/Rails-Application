class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @users = User.all
    puts @users.inspect
  end

  def show
    @user = User.find(params[:id])
  end

  # def send_request
  #   debugger
  #   friend = User.find(params[:id])
  #   current_user.sent_friend_requests.create(receiver: friend)
  #   redirect_to friend, notice: 'Friend request sent.'
  # end

  # def accept_request
  #   sender = User.find(params[:id])
  #   friend_request = current_user.received_friend_requests.pending.find_by(sender: sender)
  #   friend_request&.update(status: 'accepted')
  #   redirect_to sender, notice: 'Friend request accepted.'
  # end

  # def decline_request
  #   sender = User.find(params[:id])
  #   friend_request = current_user.received_friend_requests.pending.find_by(sender: sender)
  #   friend_request&.update(status: 'declined')
  #   redirect_to sender, notice: 'Friend request declined.'
  # end

  # Other actions like edit, update, destroy, etc.

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

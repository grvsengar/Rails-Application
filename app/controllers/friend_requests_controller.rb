class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # This sets up CanCanCan's authorization

  def send_request
    friend = User.find(params[:id])
    current_user.sent_friendships.create(receiver: friend)
    redirect_to friend, notice: 'Friend request sent.'
  end

  def accept_request
    friend = User.find(params[:id])
    friendship = current_user.received_friendships.find_by(sender: friend)
    friendship&.update(status: 'accepted')
    redirect_to friend, notice: 'Friend request accepted.'
  end
end

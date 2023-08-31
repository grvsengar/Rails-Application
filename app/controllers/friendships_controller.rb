class FriendshipsController < ApplicationController
    # def send_request
    #     debugger
    #     friend = User.find(params[:id])
    #     current_user.sent_friend_requests.create(receiver: friend)
    #     redirect_to friend, notice: 'Friend request sent.'
    #   end
    
    #   def accept_request
    #     sender = User.find(params[:id])
    #     friend_request = current_user.received_friend_requests.pending.find_by(sender: sender)
    #     friend_request&.update(status: 'accepted')
    #     redirect_to sender, notice: 'Friend request accepted.'
    #   end
    
    #   def decline_request
    #     sender = User.find(params[:id])
    #     friend_request = current_user.received_friend_requests.pending.find_by(sender: sender)
    #     friend_request&.update(status: 'declined')
    #     redirect_to sender, notice: 'Friend request declined.'
    #   end


before_action :authenticate_user!

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

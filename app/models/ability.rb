class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Abilities for sending and accepting friend requests
    can :send_request, User
    can :accept_request, User do |friend|
      user.received_friendships.pending.exists?(sender: friend)
    end
  end
end

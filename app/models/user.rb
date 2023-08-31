class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2,:facebook]
         
         def self.from_omniauth(auth)
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0, 20]
            user.full_name = auth.info.name # assuming the user model has a name
            user.avatar_url = auth.info.image # assuming the user model has an image
          end
        end
        # facebook
        # def self.from_omniauth(auth)
        #   name_split = auth.info.name.split(" ")
        #   user = User.where(email: auth.info.email).first
        #   user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
        #     user
        # end
        # ... Devise modules ...

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :pending_friends, -> { where(friendships: { status: 'pending' }) },
           through: :friendships, source: :friend
  has_many :requested_friends, -> { where(friendships: { status: 'requested' }) },
           through: :friendships, source: :friend
  has_many :posts
  has_many :comments
  rolify
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id'
  

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'
  # ... associations ...

  def superadmin?
    has_role?(:superadmin)
  end
end

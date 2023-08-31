class Post < ApplicationRecord
    belongs_to :user
  has_many :comments
  has_one_attached :image
  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller && controller.current_user }

end

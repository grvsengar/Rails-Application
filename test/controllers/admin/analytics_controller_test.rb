require "test_helper"

class Admin::AnalyticsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # endclass Admin::AnalyticsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_superadmin

  def index
    @user_count = User.count
    @post_count = Post.count
    @top_user = User.joins(:posts).group(:id).order('COUNT(posts.id) DESC').first
  end

  private

  def authorize_superadmin
    redirect_to root_path unless current_user.superadmin?
  end
end

end

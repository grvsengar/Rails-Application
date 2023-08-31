class PostMailer < ApplicationMailer
    def new_post_notification(post)
      @post = post
      superadmin = User.find_by(superadmin: true) # Find your SuperAdmin user here
  
      mail(to: superadmin.email, subject: 'New Post Notification')
    end
  end
  
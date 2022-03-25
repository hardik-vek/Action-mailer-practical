class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  mount_uploader :picture, PictureUploader

  before_update :send_edited_email

  def send_edited_email
    @user = User.find_by_id(self.id)
    if @user.email != self.email
      UserMailer.with(user: @user).edit_email.deliver_later
    end
  end
end

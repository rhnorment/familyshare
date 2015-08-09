# == Schema Information
#
# Table name: invitations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  recipient_email :string(255)
#  token           :string(255)
#  sent_at         :datetime
#  accepted_at     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

class Invitation < ActiveRecord::Base

  # model validations:
  validates       :recipient_email, :user_id, presence: true
  validates       :recipient_email, format: { with: /\A\S+@\S+\z/ }

  # data associations:
  belongs_to      :user
  has_one         :recipient, class_name: 'User'

  # callbacks
  before_create   :create_invitation_digest
  after_create    :send_invitation_email

  # creates a unique invitation token:
  def create_invitation_digest
    self.token = User.new_token
  end

  # send the invitation email:
  def send_invitation_email
    UserMailer.invitation(self).deliver_now
    update_attribute(:sent_at, Time.zone.now)
  end

  # check to see if an invitation has already been sent to the recipient email address by the user:
  def already_invited?
    Invitation.find_by_user_id_and_recipient_email(user, recipient_email).present?
  end

  # check to see if the user invited himself:
  def invited_self?
    self.recipient_email == user.email
  end

  # check to see if the user is already relatives with the invitee:
  def already_relatives_with?
    user.relatives.include?(find_recipient)
  end

  # check to see if the user is already a member:
  def is_member?
    find_recipient != nil
  end

  # find the recipient in the user table:
  def find_recipient
    User.find_by_email(recipient_email)
  end

end

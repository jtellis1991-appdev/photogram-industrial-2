# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  username               :citext
#  private                :boolean
#  likes_count            :integer          default(0)
#  comments_count         :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes, foreign_key: :fan_id
  has_many :own_photos, foreign_key: :owner_id, class_name: "Photo"
  has_many :sent_follow_requests, foreign_key :sender_id, class_name: "FollowRequest"
  has_many :accepted_sent_follow_requests, -> { where(status: "accepted") }, foreign_key :sender_id, class_name: "FollowRequest"
  has_many :received_follow_requests, foreign_key: :recipient_id, class_name: "FollowRequest"
  has_many :accepted_received_follow_requests, -> { where(status: "accepted") }, foreign_key: :recipient_id, class_name: "FollowRequest"
  has_many :comments, foreign_key: :author_id

  has_many :liked_photos, through: :likes, source: :photo
  has_many :leaders, through: :accepted_sent_follow_requests, source: recepient
  has_many :followers, through: :accepted_received_follow_requests, source: sender
  has_many :feed, through: :leaders, source: own_photos
  has_many :discover, through: :leaders, source: liked_photos
end

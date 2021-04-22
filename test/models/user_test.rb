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
#  private                :boolean          default(TRUE)
#  likes_count            :integer          default(0)
#  comments_count         :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  photos_count           :integer          default(0)
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

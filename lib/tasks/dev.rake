task sample_data: :environment do

  12.times do 
    name = Faker::Name.unique.first_name
    u = User.create(
      username: name,
      email: "#{name}@example.com",
      password: "password",
      private: [true, false].sample
    )
  end
  # p u.errors.full_messages
  p "#{User.count} users have been created"

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

end
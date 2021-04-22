task sample_data: :environment do
starting = Time.now
p "creation of sample data has begun"

if Rails.env.development?
  FollowRequest.destroy_all
  User.destroy_all
end

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
  

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  users.each do |user|

    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}?set=set4"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.robin,
            author: follower
          )
        end
      end
    end
  end
  ending = Time.now
  p "It took #{(ending -starting).to_i} seconds to create sample data"
  p "#{User.count} users have been created"
  p "#{FollowRequest.count} follow requests have been created"
  p "#{Photo.count} photos have been created"
  p "#{Like.count} likes have been created"
  p "#{Comment.count} comments have been created"
end
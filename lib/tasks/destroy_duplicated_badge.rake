namespace :sei do
  desc "Removes duplicated badge from user"

  task :destroy_duplicated_badge, [:username] => :environment do |t, args|
    user = User.find_by(username: args[:username])
    user_id = user.id
    acquisition = user.badges
    acquisition.each do |badge_id|
      badges = BadgeAcquisition.where(badge_id: badge_id, user_id: user_id)
      if badges.length > 1
        badges[1..-1].each do |badge|
          BadgeAcquisition.destroy(badge.id)
        end
      end
    end
  end
end

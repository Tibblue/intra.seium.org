namespace :sei do
  desc "Removes duplicated badge from user"

  task :destroy_duplicated_badge, [:badge, :username] => :environment do |t, args|
    badge_id  = Badge.find_by(codename: args[:badge]).id
    user_id   = User.find_by(username: args[:username]).id
    badges = BadgeAcquisition.where(badge_id: badge_id, user_id: user_id)
    if badges.length >1
      badges[1..-1].each do |badge|
        BadgeAcquisition.destroy(badge.id)
      end
    end
  end
end

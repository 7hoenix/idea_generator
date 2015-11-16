class User < ActiveRecord::Base
  def service
    @service ||= TwitterService.new(self)
  end

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.name               = auth_info.extra.raw_info.name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end

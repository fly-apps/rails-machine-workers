module Fly
  def self.api
    @api ||= Fly::API.new(api_token: env_auth_token)
  end

  def self.current
    api.application(name: env_app_name)
  end

  def self.env_app_name
    ENV["FLY_APP_NAME"]
  end

  def self.env_auth_token
    ENV["FLY_AUTH_TOKEN"]
  end
end

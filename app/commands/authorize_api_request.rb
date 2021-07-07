class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= Users.where(user_id: decoded_auth_token[:user_id]).first if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      tokenVal = headers['Authorization'].split(' ').last
      return tokenVal if REDIS.get(tokenVal).present?
    end
    errors.add(:token, 'Missing token')
    nil
  end
end
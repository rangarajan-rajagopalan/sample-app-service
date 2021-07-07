class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.user_id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = Users.where(user_id: email, user_password:password).first
    return user if user

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
class UsersController < ApplicationController
  # GET /users
  def list
    users = Users.all
    render json: {users: users}
  end

  # GET /users/:id
  def details
    user = Users.where(user_id: params[:id]).first
    if user.nil?
      render json: { error: "user not found" }, status: 404
    else
      user = user.attributes.except("user_password")
      render json: user
    end
  end

  # POST /users
  def insert
    maxUserId = Users.maximum("user_id")
    result = {}
    result[:user_id] = maxUserId.nil? ? 10000 : maxUserId +1
    result[:user_first_name] = params[:user][:user_first_name]
    result[:user_last_name] = params[:user][:user_last_name]
    result[:user_password] = params[:user][:user_password]
    result[:user_role] = "creator"
    result[:is_login_enabled] = true
    result[:is_deleted] = false

    user = Users.new(result)
    if user.save
      render json: { message: "user added", id: user[:id], user_id: result[:user_id] }, status: 200
    else
      render json: { error: "error in adding record" }, status: 500
    end
  end

  # PUT /users/:id
  def update
    user = Users.where(user_id: params[:id]).first
    if user.nil?
      render json: { error: "user not found" }, status: 404
      return
    end
    args = {
      user_first_name: params[:user][:user_first_name],
      user_last_name: params[:user][:user_last_name]
    }
    user.update_attributes(args)
    render json: { message: "user details updated", user_id: params[:id] }, status: 200
  end

  # DELETE /users/:id
  def remove
    begin
      user = Users.where(user_id: params[:id]).first
      if user.nil?
        render json: { error: "user not found" }, status: 404
      else
        user.update_column(:is_deleted, true)
        render json: { message: "user deleted", user_id: params[:id] }, status: 200
      end
    rescue => error
      puts "Error received"
      puts error
      render json: { error: "server error" }, status: 500
    end
  end

end

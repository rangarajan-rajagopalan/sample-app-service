class FoldersController < ApplicationController
  # GET /folders
  def list
    folders = Folders.where(user_id: @current_user[:user_id])
    render json: { folders: folders }
  end

  # GET /folders/:id
  def details
    user_id = @current_user[:user_id] || params[:user_id]
    folder = Folders.where(folder_id: params[:id], user_id: user_id).first
    if folder.nil?
      render json: { error: "folder not found" }, status: 404
    else
      render json: { folder: folder }
    end
  end

  # POST /folders
  def insert
    folder_name = params[:folder][:folder_name]
    folder_exists = Folders.exists?(folder_name: folder_name, user_id: @current_user[:user_id])
    if folder_exists
      render json: { error: "duplicate folder name not allowed" }, status: 400
      return
    end

    user_id = @current_user[:user_id] || params[:folder][:user_id]

    max_folder_id = Folders.unscoped.maximum("folder_id")
    arg = {
      folder_id: max_folder_id.nil? ? 10000 : max_folder_id + 1,
      folder_name: folder_name,
      user_id: user_id
    }
    folder = Folders.new(arg)
    if folder.save
      render json: { folder: { id: folder.id, folder_id: folder.folder_id } }, status: 200
    else
      puts folder.inspect
      render json: { error: "error in adding record" }, status: 500
    end
  end

  # PUT /folders/:id
  def update
    user_id = @current_user[:user_id] || params[:folder][:user_id]
    folder = Folders.where(id: params[:id], user_id: user_id).first
    if folder.nil?
      render json: { error: "folder not found" }, status: 404
    else
      folder.update_column(:folder_name, params[:folder][:folder_name])
      render json: { message: "folder details updated", folder: folder }, status: 200
    end
  end

  # DELETE /folders/:id
  def remove
    user_id = @current_user[:user_id] || params[:user_id]
    folder = Folders.where(id: params[:id], user_id: user_id).first
    if folder.nil?
      render json: { error: "folder not found" }, status: 404
    else
      folder.update_column(:is_deleted, true)
      render json: { message: "folder deleted", id: params[:id] }, status: 200
    end
  rescue => error
    logger.info "Error in deleting: #{error}"
    render json: { error: "server error" }, status: 500
  end

end

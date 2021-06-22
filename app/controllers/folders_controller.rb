class FoldersController < ApplicationController
  # GET /folders
  def list
    @folders = Folders.where(user_id: params[:user_id], is_deleted: false)
    render json: @folders
  end

  # GET /folders/:id
  def details
    @folder = Folders.where(folder_id: params[:id], user_id: params[:user_id], is_deleted: false).first
    if @folder.nil?
      render json: { error: "folder not found" }, status: 404
    else
      render json: @folder
    end
  end

  # POST /folders
  def insert
    @folderName = params[:folder][:folder_name]
    @folder = Folders.where(folder_name: @folderName, user_id: params[:user_id], is_deleted: false).first
    unless @folder.nil?
      render json: { error: "duplicate folder name not allowed" }, status: 400
      return
    end

    @maxFolderId = Folders.maximum("folder_id")
    result = {}
    result[:folder_id] = @maxFolderId.nil? ? 10000 : @maxFolderId + 1
    result[:folder_name] = @folderName
    result[:user_id] = params[:user_id]
    result[:is_deleted] = false

    @folder = Folders.new(result)
    if @folder.save
      render json: { message: "folder created", id: @folder[:id], folder_id: result[:folder_id] }, status: 200
    else
      render json: { error: "error in adding record" }, status: 500
    end
  end

  # PUT /folders/:id
  def update
    @folder = Folders.where(folder_id: params[:id], user_id: params[:user_id], is_deleted: false).first
    if @folder.nil?
      render json: { error: "folder not found" }, status: 404
    else
      @folder.update_column(:folder_name, params[:folder][:folder_name])
      @folder.save
      render json: { message: "folder details updated", folder_id: params[:id] }, status: 200
    end
  end

  # DELETE /folders/:id
  def remove
    begin
      @folder = Folders.where(folder_id: params[:id], user_id: params[:user_id], is_deleted: false).first
      if @folder.nil?
        render json: { error: "folder not found" }, status: 404
      else
        @folder.update_column(:is_deleted, true)
        @folder.save
        render json: { message: "folder deleted", folder_id: params[:id] }, status: 200
      end
    rescue => error
      puts "Error received"
      puts error
      render json: { error: "server error" }, status: 500
    end
  end

end

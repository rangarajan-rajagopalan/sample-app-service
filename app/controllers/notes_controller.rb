class NotesController < ApplicationController
  def list
    sqlConditions = "is_deleted=false and user_id= #{params[:user_id]}"
    unless params[:folder_id].nil?
      sqlConditions += " and folder_id=#{params[:folder_id]}"
    end
    @notes = Notes.where(sqlConditions)
    render json: @notes
  end

  def details
    @note = Notes.where(note_id: params[:id], user_id: params[:user_id], is_deleted:false).first
    if @note.nil?
      render json: { error: "note not found" }, status: 404
    else
      render json: @note
    end
  end

  def insert
    @folderId = params[:note][:folder_id]
    @folder = Folders.where(folder_id: @folderId, user_id: params[:user_id], is_deleted: false).first
    if @folder.nil?
      render json: { error: "folder not found" }, status: 400
      return
    end

    @maxNoteId = Notes.maximum("note_id")
    result = {}
    result[:note_id] = @maxNoteId.nil? ? 10000 : @maxNoteId + 1
    result[:notes_title] = params[:note][:note_title]
    result[:notes_description] = params[:note][:note_description]
    result[:folder_id] = @folderId
    result[:user_id] = params[:user_id]
    result[:is_deleted] = false

    @note = Notes.new(result)
    if @note.save
      render json: { message: "@note created", id: @note[:id], note_id: result[:note_id] }, status: 200
    else
      render json: { error: "error in adding note" }, status: 500
    end

  end

  def update
    @note = Notes.where(note_id: params[:id], user_id: params[:user_id], is_deleted: false).first
    if @note.nil?
      render json: { error: "note not found" }, status: 404
    else
      @folderId = params[:note][:folder_id]
      @folder = Folders.where(folder_id: @folderId, user_id: params[:user_id], is_deleted: false).first
      if @folder.nil?
        render json: { error: "folder not found" }, status: 400
        return
      end

      @note.update_column(:note_title, params[:note][:note_title])
      @note.update_column(:note_description, params[:note][:note_description])
      @note.update_column(:folder_id, @folderId)
      @note.save
      render json: { message: "note details modified", note_id: params[:id] }, status: 200
    end

  end

  def remove
    begin
      @note = Notes.where(note_id: params[:id], user_id: params[:user_id], is_deleted: false).first
      if @note.nil?
        render json: { error: "note not found" }, status: 404
      else
        @note.update_column(:is_deleted, true)
        @note.save
        render json: { message: "note deleted", note_id: params[:id] }, status: 200
      end
    rescue => error
      puts "Error received"
      puts error
      render json: { error: "server error" }, status: 500
    end
  end
end

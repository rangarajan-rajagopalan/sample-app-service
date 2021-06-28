class NotesController < ApplicationController
  def list
    notes = Notes.notes_in_folder(params[:folder_id]).where(user_id: params[:user_id])
    render json: {notes: notes}
  end

  def details
    note = Notes.where(note_id: params[:id], user_id: params[:user_id]).first
    if note.nil?
      render json: { error: "note not found" }, status: 404
    else
      render json: note
    end
  end

  def insert
    folderId = params[:note][:folder_id]
    folder = Folders.where(folder_id: folderId, user_id: params[:user_id]).first
    if folder.nil?
      render json: { error: "folder not found" }, status: 400
      return
    end

    maxNoteId = Notes.maximum(:note_id)
    args = {
      note_id: maxNoteId.nil? ? 10000 : maxNoteId + 1,
      notes_title: params[:note][:note_title],
      notes_description:  params[:note][:note_description],
      folder_id: folderId,
      user_id: params[:user_id]
    }

    note = Notes.new(args)
    if note.save
      render json: { message: "@note created", id: note[:id], note_id: note[:note_id] }, status: 200
    else
      render json: { error: "error in adding note" }, status: 500
    end

  end

  def update
    note = Notes.where(note_id: params[:id], user_id: params[:user_id]).first
    if note.nil?
      render json: { error: "note not found" }, status: 404
    else
      folderId = params[:note][:folder_id]
      folder = Folders.where(folder_id: folderId, user_id: params[:user_id]).first
      if folder.nil?
        render json: { error: "folder not found" }, status: 400
        return
      end
      args = {
        notes_title: params[:note][:note_title],
        notes_description: params[:note][:note_description],
        folder_id: folderId
      }
      note.update_attributes(args)
      render json: { message: "note details modified", note_id: params[:id] }, status: 200
    end

  end

  def remove
    begin
      note = Notes.where(note_id: params[:id], user_id: params[:user_id]).first
      if note.nil?
        render json: { error: "note not found" }, status: 404
      else
        note.update_column(:is_deleted, true)
        render json: { message: "note deleted", note_id: params[:id] }, status: 200
      end
    rescue => error
      puts "Error received"
      puts error
      render json: { error: "server error" }, status: 500
    end
  end
end

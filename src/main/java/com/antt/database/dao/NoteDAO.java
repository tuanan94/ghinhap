package com.antt.database.dao;

import java.util.List;

import com.antt.database.model.Note;

public interface NoteDAO {
	public List<Note> list();
	public boolean addNote(Note note);
	public Note findNote(String noteId);
	public boolean editNote(Note note);
	public boolean setLock(String Noteid, boolean isLock);
}

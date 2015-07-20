package com.antt.database.dao;

import java.util.List;

import com.antt.database.model.Note;
import com.antt.database.model.NotePass;

public interface NotePassDAO {
	public boolean addNotePass(NotePass notePass);
	public NotePass findNotePass(String noteId);
	public boolean editNotePass(NotePass notePass);
}

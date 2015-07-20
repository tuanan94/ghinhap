package com.antt.database.model;

import java.sql.Date;

public class NotePass {
	private String noteId;
	private String password;
	private Date updateTime;
	public NotePass() {
		// TODO Auto-generated constructor stub
	}
	public NotePass(String nodeId, String password, Date updateTime) {
		this.noteId = nodeId;
		this.password = password;
		this.updateTime = updateTime;
	}
	
	
	public String getNoteId() {
		return noteId;
	}
	public void setNoteId(String noteId) {
		this.noteId = noteId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
}

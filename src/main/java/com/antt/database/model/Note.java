package com.antt.database.model;

import java.sql.Date;

public class Note {
	private String noteid;
	private String content;
	private int type;
	private Date createddate;
	private Date modifydate;
	public String getNoteid() {
		return noteid;
	}
	public void setNoteid(String noteid) {
		this.noteid = noteid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Date getCreateddate() {
		return createddate;
	}
	public void setCreateddate(Date createddate) {
		this.createddate = createddate;
	}
	public Date getModifydate() {
		return modifydate;
	}
	public void setModifydate(Date modifydate) {
		this.modifydate = modifydate;
	}
	public Note() {
		// TODO Auto-generated constructor stub
	}
	public Note(String noteid, String content, int type, Date createdDate, Date ModifyDate) {
		this.noteid = noteid;
		this.content =  content;
		this.type = type;
		this.createddate = createdDate;
		this.modifydate = ModifyDate;
		
	}
	@Override
	public String toString() {
		StringBuilder builder =  new StringBuilder();
		builder.append("NoteID: ");
		builder.append(noteid);
		builder.append("Content: ");
		builder.append(content);
		builder.append("type: ");
		builder.append(type);
		builder.append("Created date: ");
		builder.append(createddate);
		builder.append("Modify date: ");
		builder.append(modifydate);
		return builder.toString();
		
	}
	
	
	
}

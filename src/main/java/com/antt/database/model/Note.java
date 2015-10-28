package com.antt.database.model;

import java.sql.Date;

public class Note {
	private String noteid;
	private String content;
	private Integer type;
	private boolean lock;
	private boolean secure;
	private Date createddate;
	private Date modifydate;
	public String getNoteid() {
		return noteid;
	}
	
	public boolean isSecure() {
		return secure;
	}

	public void setSecure(boolean secure) {
		this.secure = secure;
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
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
	
	
	public boolean isLock() {
		return lock;
	}
	public void setLock(boolean lock) {
		this.lock = lock;
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
		this.lock = false;
		
	}
	public Note(String noteid, String content, int type, Date createdDate, Date ModifyDate, boolean isLocked, boolean isSecure) {
		this.noteid = noteid;
		this.content =  content;
		this.type = type;
		this.createddate = createdDate;
		this.modifydate = ModifyDate;
		this.lock = isLocked;
		this.secure = isSecure;
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

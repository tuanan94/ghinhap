package com.antt.database.dao;

import java.sql.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.transaction.annotation.Transactional;

import com.antt.database.model.Note;
import com.antt.database.model.NotePass;
import com.sun.xml.internal.bind.v2.model.core.ID;

public class NotePassDAOImpl implements NotePassDAO {
	private SessionFactory sessionFactory;

	public NotePassDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	@Transactional
	public boolean addNotePass(NotePass notePass) {
		if (sessionFactory == null) {
			return false;
		}
		if (findNotePass(notePass.getNoteId())!=null) {
			return false;
		}
		Session session = sessionFactory.getCurrentSession();
		session.save(notePass);
		return true;
		
	}

	@Override
	@Transactional
	public NotePass findNotePass(String noteId) {
		if (sessionFactory == null) {
			return null;
		}
		NotePass note = (NotePass) sessionFactory.getCurrentSession().get(NotePass.class, noteId);
		return note;
	}

	@Override
	@Transactional
	public boolean editNotePass(NotePass notePass) {
		NotePass oldNotePass = findNotePass(notePass.getNoteId());
		if (oldNotePass==null) {
			oldNotePass = new NotePass();
		}
		oldNotePass.setNoteId(notePass.getNoteId());
		oldNotePass.setPassword(notePass.getPassword());
		oldNotePass.setUpdateTime(new Date(new java.util.Date().getTime()));
		sessionFactory.getCurrentSession().save(oldNotePass);
		return false;
	}

	

}

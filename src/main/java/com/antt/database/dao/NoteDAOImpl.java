package com.antt.database.dao;

import java.sql.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.transaction.annotation.Transactional;

import com.antt.database.model.Note;
import com.sun.xml.internal.bind.v2.model.core.ID;

public class NoteDAOImpl implements NoteDAO {
	private SessionFactory sessionFactory;

	public NoteDAOImpl(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	@Transactional
	public List<Note> list() {
		return sessionFactory.getCurrentSession().createCriteria(Note.class)
				.list();
	}

	@Override
	@Transactional
	public boolean addNote(Note note) {
		if (sessionFactory == null) {
			return false;
		}
		Session session = sessionFactory.getCurrentSession();
		session.save(note);
		return true;
	}
	@Override
	@Transactional
	public Note findNote(String noteId){
		if (sessionFactory == null) {
			return null;
		}
		Note note = (Note) sessionFactory.getCurrentSession().get(Note.class, noteId);
		return note;
	}

	@Override
	@Transactional
	public boolean editNote(Note note) {
		Note oldNote = findNote(note.getNoteid());
		if (oldNote==null) {
			System.out.println("oldNote == null");
			return false;
			
		}
		oldNote.setContent(note.getContent());
		oldNote.setType(note.getType());
		oldNote.setModifydate(new Date(new java.util.Date().getTime()));
		sessionFactory.getCurrentSession().save(oldNote);
		return false;
	}
	

}

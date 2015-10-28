package com.antt.database.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

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
	public Note findNote(String noteId) {
		if (sessionFactory == null) {
			return null;
		}
		Note note = (Note) sessionFactory.getCurrentSession().get(Note.class,
				noteId);
		return note;
	}

	@Override
	@Transactional
	public boolean editNote(Note note) {
		Note oldNote = findNote(note.getNoteid());
		if (oldNote == null) {
			System.out.println("oldNote == null");
			return false;
		}
//		if (oldNote.isLock()) {
//			return false;
//		}
		oldNote.setContent(note.getContent());
		oldNote.setType(note.getType());
		oldNote.setModifydate(new Date(new java.util.Date().getTime()));
		sessionFactory.getCurrentSession().save(oldNote);
		return false;
	}

	@Override
	@Transactional
	public boolean setLock(String Noteid, boolean isLock, boolean lock_type) {
		Note oldNote = findNote(Noteid);
		oldNote.setLock(isLock);
		oldNote.setSecure(lock_type);
		sessionFactory.getCurrentSession().save(oldNote);
		return false;
	}

	@Override
	@Transactional
	public ArrayList<String> getLastestNotes() {
		ArrayList<Note> noteList = (ArrayList<Note>) sessionFactory
				.getCurrentSession()
				.createQuery("FROM Note WHERE islock = false AND length(id) < 12 ORDER BY modifydate DESC")
				.setMaxResults(20).list();
		ArrayList<String> stringNotes = new ArrayList<String>();
		if (noteList == null) {
			return new ArrayList<String>();
		}
		for (int i = 0; i < noteList.size(); i++) {
			stringNotes.add(noteList.get(i).getNoteid());
		}
		return stringNotes;
	}

}

package com.antt.ghichu;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Locale;

import javax.activation.URLDataSource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.antt.database.dao.NoteDAO;
import com.antt.database.dao.NotePassDAO;
import com.antt.database.model.Note;
import com.antt.database.model.NotePass;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	int userCount = 0;
	private static final String emptyLines = "\\n" + "\\n" + "\\n" + "\\n"
			+ "\\n" + "\\n" + "\\n" + "\\n" + "\\n" + "\\n" + "\\n" + "\\n"
			+ "\\n" + "\\n" + "\\n" + "\\n" + "\\n" + "\\n";
	@Autowired
	NoteDAO noteDAO;
	@Autowired
	NotePassDAO notePassDAO;

	/**
	 * Simply selects the home view to render by returning its name.
	 * value={"/method1","/method1/second"}
	 */

	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String home2(Locale locale, Model model) {
		noteDAO.getLastestNotes();
		return "homepage_public";
	}

//	@RequestMapping(value = { "/{id}/**" }, method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
//	public String subHome(Locale locale, Model model,
//			@PathVariable("id") String id, HttpServletRequest request,
//			HttpServletResponse response) {
//		return "redirect:/" + id;
//	}

	@RequestMapping(value = { "/{id}" }, method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String home(Locale locale, Model model,
			@PathVariable("id") String id, HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		userCount++;
		System.out.println(userCount);
		String fixId = id.replaceAll(" ", "");
		if (id.equals(fixId)) { // When the url is correct and dont have
								// anychange;
			try {
				fixId = URLEncoder.encode(fixId, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(fixId);
			if (fixId.length() > 200) {
				System.out.println("ID>200");
				fixId = fixId.substring(0, 200);
				return "redirect:/" + fixId;
			}
			System.out.println(fixId.length());
			Note curNote = noteDAO.findNote(fixId);
			if (curNote == null) { // neu chua co thi tao moi
				Date date = new Date(new java.util.Date().getTime());

				curNote = new Note(fixId, "", 0, date, date);
				noteDAO.addNote(curNote);
			}
			
			if(!curNote.isSecure()){	
				// Add more empty line to note
//				curNote.setContent(curNote.getContent() + emptyLines);
	
				// Add more empty line to note
				model.addAttribute("contents",
						curNote.getContent() );
			} else {
				String message = "Vui lòng nhập password để thấy nội dung này!" + emptyLines;
				model.addAttribute("contents",message);
			}
			model.addAttribute("noteid", curNote.getNoteid());
			model.addAttribute("type", curNote.getType());
			model.addAttribute("isLock", curNote.isLock());
			model.addAttribute("isSecure", curNote.isSecure());
			String userAgent = request.getHeader("User-Agent");

			System.out.println(userAgent);
			if (userAgent.contains("Mobile") || userAgent.contains("Android")) {
				return "mainView_Mobile";
			}
			return "autoresize";
		}
		return "redirect:/" + fixId;
	}

	@RequestMapping(value = "/ajax/savecontent", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String getList(
			@RequestParam(value = "contents", required = false) String contents,
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "type", required = false) String type) {
		String receivedContents = contents;
		Date date = new Date(new java.util.Date().getTime());
//		while (receivedContents.length() > 0
//				&& receivedContents.charAt(receivedContents.length() - 1) == 10) {
//			receivedContents = receivedContents.substring(0,
//					receivedContents.length() - 1);
//		}
//		for (int i = receivedContents.length() - 1; i >= 0; i--) {
//			// t = receivedContents.charAt(i);
//			// System.out.println((int)t);
//		}
		Note note = noteDAO.findNote(noteid);
		note.setModifydate(date);
		note.setContent(receivedContents);
		note.setType(Integer.parseInt(type));
		noteDAO.editNote(note);
		return "true";
	}

	@RequestMapping(value = "/ajax/setpassword", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String setPassword(
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "lock_type", required = false) String lock_type,
			@RequestParam(value = "password", required = false) String password) {
		if (password == null || password.equals("")) {
			return "Password không được để trống!";
		}
		NotePass getOldNotePass = notePassDAO.findNotePass(noteid);
		if (getOldNotePass != null
				&& (!getOldNotePass.getPassword().equals(""))) {
			return "false";
		}
		Date date = new Date(new java.util.Date().getTime());
		NotePass newNotePass = new NotePass(noteid, password, date);
		notePassDAO.editNotePass(newNotePass);
		System.out.println("lock type: " + lock_type);
		noteDAO.setLock(noteid, true,lock_type.equals("secure") ? true : false);
				
		return "true";
	}

	@RequestMapping(value = "/ajax/unsetpassword", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String unSetPassword(
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "password", required = false) String password) {

		Note note = noteDAO.findNote(noteid);
		NotePass getOldNotePass = notePassDAO.findNotePass(noteid);
		if (getOldNotePass == null
				|| (!getOldNotePass.getPassword().equals(password))) {
			return "Password không đúng!";
		}
		
		if(!note.isSecure()){
			Date date = new Date(new java.util.Date().getTime());
			NotePass newNotePass = new NotePass(noteid, "", date);
			notePassDAO.editNotePass(newNotePass);
			
			noteDAO.setLock(noteid, false,false);
			return "true";
		} else {
			return "false";
		}
		
	}
	
	@RequestMapping(value = "/ajax/getcontent", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String getcontent(
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "password", required = false) String password) {
		Note note = noteDAO.findNote(noteid);
		NotePass getOldNotePass = notePassDAO.findNotePass(noteid);
		if (getOldNotePass == null
				|| (!getOldNotePass.getPassword().equals(password))) {
			return "";
		}
		String content = note.getContent() + emptyLines;
		
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(content);
		return note.getContent();
	}

	@RequestMapping(value = "/ajax/getCanvasContent", method = RequestMethod.POST, headers = "Accept=application/json")
	public @ResponseBody ArrayList<String> getCanvasContent() {

		return (ArrayList<String>) noteDAO.getLastestNotes();
	}

}

package com.antt.ghichu;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

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

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	int userCount = 0;
	private static final String emptyLines = "\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n"+"\\n";
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
		//return "redirect:/public";
		return "homepage_public";
	}

	@RequestMapping(value = { "/{id}" }, method = RequestMethod.GET)
	public String home(Locale locale, Model model,
			@PathVariable("id") String id, HttpServletRequest request) {
		userCount++;
		System.out.println(userCount);
		String fixId = id.replaceAll("[^\\x20-\\x7e]", "").replaceAll(" ", "");
		if (id.equals(fixId)) { // When the url is correct and dont have
								// anychange;

			Note curNote = noteDAO.findNote(fixId);
			if (curNote == null) { // neu chua co thi tao moi
				Date date = new Date(new java.util.Date().getTime());
				curNote = new Note(fixId, "", 0, date, date);
				noteDAO.addNote(curNote);
			}
			//Add more empty line to note
			curNote.setContent(curNote.getContent()+emptyLines);
			
			
			
			
			//Add more empty line to note
			model.addAttribute("contents",
					curNote.getContent()
							.replaceAll("(\\r|\\n|\\r\\n)", "\\\\n")
							.replaceAll("'", "\\\\'"));

			model.addAttribute("noteid", curNote.getNoteid());
			model.addAttribute("type", curNote.getType());
			model.addAttribute("isLock", curNote.isLock());
			String userAgent = request.getHeader("User-Agent");
			if (userAgent.contains("Mobile")) {
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
		while (receivedContents.length()>0 && receivedContents.charAt(receivedContents.length()-1)==10) {
			receivedContents = receivedContents.substring(0, receivedContents.length()-1);
		}
		for (int i = receivedContents.length()-1; i >= 0; i--) {
//			t = receivedContents.charAt(i);
//			System.out.println((int)t);
		}
		noteDAO.editNote(new Note(noteid, receivedContents, Integer.parseInt(type),
				date, date));
		return "true";
	}

	@RequestMapping(value = "/ajax/setpassword", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String setPassword(
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "password", required = false) String password) {
		if (password==null||password.equals("")) {
			return "false";
		}
		NotePass getOldNotePass = notePassDAO.findNotePass(noteid);
		if (getOldNotePass!=null&&(!getOldNotePass.getPassword().equals(""))) {
			return "false";
		}
		Date date = new Date(new java.util.Date().getTime());
		NotePass newNotePass = new NotePass(noteid, password, date);
		notePassDAO.editNotePass(newNotePass);
		noteDAO.setLock(noteid, true);
		
		return "true";
	}
	
	@RequestMapping(value = "/ajax/unsetpassword", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String unSetPassword(
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "password", required = false) String password) {
		System.out.println("Unset Password FunctionnIscalled with noteid="+noteid
				+"password"+password);
		NotePass getOldNotePass = notePassDAO.findNotePass(noteid);
		if (getOldNotePass==null||(!getOldNotePass.getPassword().equals(password))) {
			return "Password không đúng!";
		}
		Date date = new Date(new java.util.Date().getTime());
		NotePass newNotePass = new NotePass(noteid, "", date);
		notePassDAO.editNotePass(newNotePass);
		
		noteDAO.setLock(noteid, false);
		
		return "true";
	}
	@RequestMapping(value = "/ajax/getCanvasContent", method = RequestMethod.POST, headers = "Accept=application/json")
	public @ResponseBody ArrayList<String> getCanvasContent() {
		
		return (ArrayList<String>) noteDAO.getLastestNotes();
	}
	
}

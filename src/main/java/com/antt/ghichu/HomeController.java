package com.antt.ghichu;

import java.sql.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.dbcp2.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.antt.database.dao.NoteDAO;
import com.antt.database.dao.NoteDAOImpl;
import com.antt.database.model.Note;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	int userCount = 0;
	@Autowired
	NoteDAO noteDAO;

	// private static final Logger logger =
	// LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * value={"/method1","/method1/second"}
	 */
	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String home2(Locale locale, Model model) {

		return "redirect:/public";
	}

	@RequestMapping(value = { "/{id}" }, method = RequestMethod.GET)
	public String home(Locale locale, Model model, @PathVariable("id") String id
			,HttpServletRequest request) {
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
			model.addAttribute("contents",
					curNote.getContent()
							.replaceAll("(\\r|\\n|\\r\\n)", "\\\\n")
							.replaceAll("'", "\\\\'"));
			model.addAttribute("noteid", curNote.getNoteid());
			model.addAttribute("type", curNote.getType());
			String userAgent = request.getHeader("User-Agent");
			if (userAgent.contains("Mobile")) {
				return "mainView_Mobile";
			}
			System.out.println(userAgent);
			return "autoresize";
		}
		return "redirect:/" + fixId;
	}

	@RequestMapping(value = "/ajax/savecontent", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String getList(
			@RequestParam(value = "contents", required = false) String contents,
			@RequestParam(value = "noteid", required = false) String noteid,
			@RequestParam(value = "type", required = false) String type) {
		System.out.println("Receive add request " + contents + noteid + type);
		Date date = new Date(new java.util.Date().getTime());
		noteDAO.editNote(new Note(noteid, contents, Integer.parseInt(type),
				date, date));
		return "true";
	}

}

package com.watchers.business.contact.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.watchers.business.contact.model.BoardVo;
import com.watchers.business.contact.service.ContactService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class ContactController {
	Logger logger = LoggerFactory.getLogger(ContactController.class);
	
	@Autowired
	ContactService contactService;
	
	@RequestMapping(value = "Contact.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView goContact(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/contact_list");
		
		mav.addObject("ContactList", contactService.getBoardList());
		
		return mav;
	}
	
	@RequestMapping(value = "ContactWrite.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView goContactWrite(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/contact_write");
		return mav;
	}
	
	@RequestMapping(value = "ContactWrite.action", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject procContactWrite(HttpServletRequest request, HttpServletResponse response, BoardVo boardInfo){
		return contactService.procContactWrite(boardInfo);
	}
	
	@RequestMapping(value = "ContactRead.watchers", method = RequestMethod.POST)
	public ModelAndView goContactRead(HttpServletRequest request, HttpServletResponse response, BoardVo boardInfo){
		ModelAndView mav = new ModelAndView("/contact_read");
		
		mav.addObject("ContactInfo", contactService.getBoard(boardInfo));
		
		return mav;
	}
	
	@RequestMapping(value = "ContactModify.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView goContactModify(HttpServletRequest request, HttpServletResponse respone, BoardVo boardInfo){
		ModelAndView mav = new ModelAndView("/contact_write");
		
		mav.addObject("ContactInfo", contactService.getBoard(boardInfo));
		
		return mav;
	}
	
	@RequestMapping(value = "ContactModify.action", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject procContactModify(HttpServletRequest request, HttpServletResponse response, BoardVo boardInfo){
		return contactService.procContactModify(boardInfo);
	}
	
	@RequestMapping(value = "ContactRemove.action", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject procContactRemove(HttpServletRequest request, HttpServletResponse response, BoardVo boardInfo){
		return contactService.procContactRemove(boardInfo);
	}
}

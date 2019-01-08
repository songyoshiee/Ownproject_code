package com.watchers.business.main.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class MainController {
	Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "Main.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public String goMain(HttpServletRequest request){
		return "/main";
	}
	
	@RequestMapping(value = "About.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public String goMenual(HttpServletRequest request){
		return "/manual";
	}
	
}

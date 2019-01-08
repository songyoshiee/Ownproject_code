package com.watchers.business.regist.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.watchers.business.login.model.UserVo;
import com.watchers.business.login.web.LoginController;
import com.watchers.business.regist.service.RegistService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class RegistController {
	Logger logger = LoggerFactory.getLogger(RegistController.class);
	
	@Autowired
	RegistService registService;
	
	@RequestMapping(value = "Register.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public String goRegist(HttpServletRequest request){
		return "/register";
	}
	
	@RequestMapping(value = "Register.action", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public JSONObject procRegist(HttpServletRequest request, UserVo user){
		return registService.procRegist(user);
	}
}

package com.watchers.business.login.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.watchers.business.login.model.UserVo;
import com.watchers.business.login.service.LoginService;
import com.watchers.common.session.manager.SessionLoginUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class LoginController {
	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping(value = "Login.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public String goLogin(HttpServletRequest request){
		return "/login";
	}
	
	@RequestMapping(value = "Login.action", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject goLoginProc(HttpServletRequest request, UserVo user){
		return loginService.getUser(user);
	}
	
	@RequestMapping(value="Logout.watchers", method = {RequestMethod.GET,RequestMethod.POST})
	public String goLogout(HttpServletRequest request){
		SessionLoginUtil.procLogout();
		return "redirect:/Main.watchers";
	}
}

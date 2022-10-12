package com.iyoons.world.controller;

import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AllErrorController implements ErrorController{

	@RequestMapping(value="/error")
	public String error(HttpServletRequest request,Model model) {
		
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		System.out.println(status);
		HttpStatus httpstatus = HttpStatus.valueOf(Integer.valueOf(status.toString()));//httpstatus enum의 값으로
		System.out.println(httpstatus);
		System.out.println(httpstatus.getReasonPhrase());
		model.addAttribute("code",status.toString());
		model.addAttribute("msg",httpstatus.getReasonPhrase());
		model.addAttribute("timestamp", new Date());
		
		if(Integer.valueOf(status.toString()) == 404) {
			return "error/404error";
		}
		if(Integer.valueOf(status.toString()) == 500) {
			return "error/500error";
		}
        return "error/error";
	}
	
}

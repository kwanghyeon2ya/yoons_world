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
	public String error(HttpServletRequest request,Model model) { // 에러 페이지 이동
		
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		HttpStatus httpstatus = HttpStatus.valueOf(Integer.valueOf(status.toString()));//httpstatus enum의 값으로
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

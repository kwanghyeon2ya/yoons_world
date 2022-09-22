package com.iyoons.world.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.iyoons.world.service.DemoService;
import com.iyoons.world.vo.DemoVO;

@Controller
@RequestMapping("/demo")
public class DemoController {
	
	@Autowired
	DemoService demoService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/getDemoList")
	public String index(Model model, HttpSession session) {
		
		List<DemoVO> list = demoService.getDemoList();
		
		logger.info("list size : "+list.size());
		
		model.addAttribute("list", list);
		return "demo/getDemoList";
	}	

	@GetMapping("/getDemoInfo")
	public String getDemoInfo(Model model, HttpSession session, DemoVO param) {
		
		DemoVO info = demoService.getDemoInfo(param);
		
		model.addAttribute("info", info);
		return "demo/getDemoInfo";
	}		
	
	@GetMapping("/regDemoInfo")
	public String regDemoInfo(Model model, HttpSession session, DemoVO param) {
		
		if(param.getDemoNo() > 0) {
			DemoVO info = demoService.getDemoInfo(param);
			
			model.addAttribute("info", info);
		}
		
		return "demo/regDemoInfo";
	}	
	
	
	@PostMapping("/regDemoProc")
	public String regDemoProc(Model model, HttpSession session, DemoVO param) {
		
		demoService.regDemoProc(param);
		
		model.addAttribute("result", param.getResult());
		
		return "demo/regDemoResult";
	}
	
	@PostMapping("/modDemoProc")
	public String modDemoProc(Model model, HttpSession session, DemoVO param) {
		
		demoService.modDemoProc(param);
		
		model.addAttribute("result", param.getResult());
		
		return "demo/regDemoResult";
	}
}

package com.iyoons.sample.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.sample.service.DemoService;
import com.iyoons.sample.vo.DemoVO;

@Controller
public class DemoController {
	
	@Autowired
	DemoService demoService;

	@GetMapping("/demo")
	public String index(Model model, HttpSession session) {
		
		List<DemoVO> list = demoService.getDemoList();
		
		model.addAttribute("list", list);
		return "demo";
	}	
	
	
	@ResponseBody
	@GetMapping("getDemoList")
	public List<DemoVO> getDemoList(HttpSession session) {
		
		List<DemoVO> list = demoService.getDemoList();
		
		return list;
	}

	
}

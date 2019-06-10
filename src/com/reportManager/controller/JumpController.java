package com.reportManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JumpController {

	@RequestMapping("/jump")
	public String jump(String type, String pageCode){
		return "redirect:" + type + "/" + pageCode + ".jsp";
	}
	
}

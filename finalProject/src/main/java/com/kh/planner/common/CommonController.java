package com.kh.planner.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController { 	
	@RequestMapping(value = "header.do")
	public String header() {
		return "common/header";
	}
	
	@RequestMapping(value = "footer.do")
	public String footer() {
		return "common/footer";
	}
	
	@RequestMapping(value = "area_header.do")
	public String area_header() {
		return "area/area_header";
	}
}

package com.kh.planner.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommonController {
	@RequestMapping(value = "header.do", method = RequestMethod.GET)
	public String header() {
		return "common/header";
	}
	
	@RequestMapping(value = "footer.do", method = RequestMethod.GET)
	public String footer() {
		return "common/footer";
	}
	
	@RequestMapping(value = "area.do", method = RequestMethod.GET)
	public String area() {
		return "area/area";
	}
	
	@RequestMapping(value = "hotel.do", method = RequestMethod.GET)
	public String hotel() {
		return "hotel/hotel";
	}
}

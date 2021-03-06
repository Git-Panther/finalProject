package com.kh.planner.use;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UseController {
	
	private static final Logger logger = LoggerFactory.getLogger(UseController.class);
	@RequestMapping(value = "use.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		
		return "use/use";
	}
	
}

package com.kh.planner.common;

<<<<<<< HEAD
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
=======
>>>>>>> branch 'master' of https://github.com/uik7300/finalProject
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
	
	@RequestMapping(value = "searchContent.do", produces="application/json; charset=UTF-8")	
	public ModelAndView searchContent(ModelAndView mv,
			@RequestParam(value="keyword", defaultValue="") String keyword,
			@RequestParam(value="pageNo", defaultValue="1") String pageNo) {
		mv.addObject("keyword", keyword);
		mv.addObject("pageNo", pageNo);
		mv.setViewName("common/searchResult");
		return mv;
	}
	
	@RequestMapping( value = "searchList.do", produces="application/json; charset=UTF-8")
	public void searchContent(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="keyword", defaultValue = "") String keyword,
			@RequestParam(value="curPage", defaultValue = "1") String curPage) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String result = JsonParser.getSearchKeyword(keyword, curPage);
		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}
}

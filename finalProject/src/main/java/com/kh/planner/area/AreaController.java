package com.kh.planner.area;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.planner.common.JsonParser;

@Controller
public class AreaController {

	private static final Logger logger = LoggerFactory.getLogger(AreaController.class);

	@RequestMapping(value = "area.do", method = RequestMethod.GET)
	public ModelAndView area(ModelAndView mv) {
		mv.addObject("sidoName", "-1");
		mv.addObject("sidoCode", "-1");
		mv.addObject("sigunguName", "-1");
		mv.addObject("sigunguCode", "-1");
		
		mv.setViewName("area/area");
		return mv;
	}

	@RequestMapping(value = "areaList.do", method = RequestMethod.GET)
	public void areaList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getAreaList();

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}

	@RequestMapping(value = "sigunguCount.do", method = RequestMethod.GET)
	public void sigunguCount(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam String sidoCode)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getSigunguCount(sidoCode);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}

	@RequestMapping(value = "sigunguList.do", method = RequestMethod.GET)
	public void sigunguList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam String sidoCode,
			@RequestParam String numOfSigungu) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getSigunguList(sidoCode, numOfSigungu);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}

	@RequestMapping(value = "popList.do")
	public void popList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(defaultValue = "-1") String sidoCode,
			@RequestParam(defaultValue = "-1") String sigunguCode, 
			@RequestParam(defaultValue = "-1") String contenttypeid) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getPopList(sidoCode, sigunguCode, contenttypeid);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}
	
	@RequestMapping(value = "areaMenu.do", method = RequestMethod.POST)
	public ModelAndView areaMenu(ModelAndView mv,
			@RequestParam(defaultValue = "-1") String sidoName,
			@RequestParam(defaultValue = "-1") String sidoCode,
			@RequestParam(defaultValue = "-1") String sigunguName,
			@RequestParam(defaultValue = "-1") String sigunguCode,
			@RequestParam(defaultValue = "-1") String contenttypeid,
			@RequestParam(defaultValue = "-1") String contenttypename,
			@RequestParam(defaultValue = "home") String menu
			) throws Exception{
		mv.addObject("sidoName", sidoName);
		mv.addObject("sidoCode", sidoCode);
		mv.addObject("sigunguName", sigunguName);
		mv.addObject("sigunguCode", sigunguCode);
		if(menu.equals("attraction")) {
			contenttypeid = "12";
		} else if(menu.equals("culture")) {
			contenttypeid = "14";
		} else if(menu.equals("hotel")) {
			contenttypeid = "32";
		} else if(menu.equals("shopping")) {
			contenttypeid = "38";
		} else if(menu.equals("restaurant")) {
			contenttypeid = "39";
		}
		mv.addObject("contenttypeid", contenttypeid);
		mv.addObject("contenttypename", contenttypename);
		mv.addObject("menu", menu);

		mv.setViewName("area/area_" + menu);
		return mv;
	}
	
	
	@RequestMapping("getList.do")
	public void selectHotelList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "-1") String sidoCode,
			@RequestParam(defaultValue = "-1") String sigunguCode,
			@RequestParam(defaultValue = "-1") String contenttypeid,
			@RequestParam(defaultValue = "B") String arrange,
			@RequestParam(defaultValue = "1") String pageNo) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getContentList(sidoCode, sigunguCode, contenttypeid, arrange, pageNo);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}
	
}

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
	public String area() {
		return "area/area";
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
	}//dddddddd

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

	@RequestMapping(value = "popList.do", method = RequestMethod.GET)
	public void popList(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(defaultValue = "-1") String sidoCode,
			@RequestParam(defaultValue = "-1") String sigunguCode, 
			@RequestParam String contentTypeId) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getPopList(sidoCode, sigunguCode, contentTypeId);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}
	
	/*$("<input type='hidden'>").attr("name", "sidoName").val(sidoName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sidoCode").val(sidoCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguName").val(sigunguName).appendTo(form);
	$("<input type='hidden'>").attr("name", "sigunguCode").val(sigunguCode).appendTo(form);
	$("<input type='hidden'>").attr("name", "contenttypename").val(contenttypename).appendTo(form);
	$("<input type='hidden'>").attr("name", "contentid").val(contentid).appendTo(form);
	$("<input type='hidden'>").attr("name", "title").val(title).appendTo(form);*/
	
	@RequestMapping(value = "areaMain.do", method = RequestMethod.POST)
	public ModelAndView areaMain(ModelAndView mv,
			@RequestParam(defaultValue = "-1") String sidoName,
			@RequestParam(defaultValue = "-1") String sidoCode,
			@RequestParam(defaultValue = "-1") String sigunguName,
			@RequestParam(defaultValue = "-1") String sigunguCode,
			@RequestParam(defaultValue = "-1") String contenttypeid,
			@RequestParam(defaultValue = "-1") String contenttypename,
			@RequestParam(defaultValue = "-1") String contentid,
			@RequestParam(defaultValue = "-1") String title
			) throws Exception{
		
		mv.addObject("sidoName", sidoName);
		mv.addObject("sidoCode", sidoCode);
		mv.addObject("sigunguName", sigunguName);
		mv.addObject("sigunguCode", sigunguCode);
		mv.addObject("contenttypeid", contenttypeid);
		mv.addObject("contenttypename", contenttypename);
		mv.addObject("contentid", contentid);
		mv.addObject("title", title);

		mv.setViewName("area/areaMain");
		return mv;
	}
	
	@RequestMapping(value = "contentDetail.do")
	public ModelAndView areaDetail(ModelAndView mv,
			@RequestParam(defaultValue = "-1") String sidoName,
			@RequestParam(defaultValue = "-1") String sidoCode,
			@RequestParam(defaultValue = "-1") String sigunguName,
			@RequestParam(defaultValue = "-1") String sigunguCode,
			@RequestParam(defaultValue = "-1") String contenttypeid,
			@RequestParam(defaultValue = "-1") String contenttypename,
			@RequestParam(defaultValue = "-1") String contentid,
			@RequestParam(defaultValue = "-1") String title
			) throws Exception{
		
		mv.addObject("sidoName", sidoName);
		mv.addObject("sidoCode", sidoCode);
		mv.addObject("sigunguName", sigunguName);
		mv.addObject("sigunguCode", sigunguCode);
		mv.addObject("contenttypeid", contenttypeid);
		mv.addObject("contenttypename", contenttypename);
		mv.addObject("contentid", contentid);
		mv.addObject("title", title);
		
		mv.setViewName("area/contentDetail");
		return mv;
	}

}

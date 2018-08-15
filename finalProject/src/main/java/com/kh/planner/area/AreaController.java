package com.kh.planner.area;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	}
	
	@RequestMapping(value = "sigunguCount.do", method = RequestMethod.GET)
	public void sigunguCount(HttpServletRequest request, HttpServletResponse response,
			@RequestParam String areaCode) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getSigunguCount(areaCode);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}
	
	@RequestMapping(value = "sigunguList.do", method = RequestMethod.GET)
	public void sigunguList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam String areaCode, @RequestParam String numOfSigungu) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String result = JsonParser.getSigunguList(areaCode, numOfSigungu);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}
	
}

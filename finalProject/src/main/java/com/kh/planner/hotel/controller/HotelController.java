package com.kh.planner.hotel.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.planner.common.JsonParser;
import com.kh.planner.hotel.model.service.HotelService;

@Controller
public class HotelController {

	@Autowired
	HotelService service;

	@RequestMapping("hotel.do")
	public String hotelList() {

		return "hotel/hotelList";
	}

	@RequestMapping("hotelList.do")
	public void selectHotelList(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "areaCode") String areaCode,
			@RequestParam(value = "sigunguCode") String sigunguCode,
			@RequestParam(value = "arrange") String arrange,
			@RequestParam(value = "pageNo") String pageNo) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		JsonParser jp = new JsonParser();
		String result = jp.getSearchStay(areaCode, sigunguCode, arrange, pageNo);

		PrintWriter out = response.getWriter();
		out.println(result);
		JSONObject json = new JSONObject();
		json.put("data", result);
	}

}

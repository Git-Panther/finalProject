package com.kh.planner.favorite.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.planner.favorite.model.service.FavoriteService;
import com.kh.planner.festival.controller.FestivalController;

@Controller
public class FavoriteController {
	private static final Logger logger = LoggerFactory.getLogger(FestivalController.class);
	
	@Autowired
	private FavoriteService service;
	
	// 찜 검사
	@RequestMapping(value = "checkFavorite.do", method = RequestMethod.POST)
	public @ResponseBody boolean checkFavorite(
			@RequestParam(value="userno", defaultValue = "-1") int userno, 
			@RequestParam(value="contenttypeid", defaultValue = "-1") int contenttypeid, 
			@RequestParam(value="contentid", defaultValue = "-1") int contentid){	
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("userno", userno);
		params.put("contenttypeid", contenttypeid);
		params.put("contentid", contentid);
		HashMap<String, Integer> response = service.checkFavorite(params);
		boolean result = false;
		logger.info("checkFavorite.do : " + (null != response ? response.toString() : null));
		if(response != null) result = true;
		return result;
	}
	
	// 찜 추가
	@RequestMapping(value = "insertFavorite.do", method = RequestMethod.POST)
	public @ResponseBody boolean insertFavorite(
			@RequestParam(value="userno", defaultValue = "-1") int userno, 
			@RequestParam(value="contenttypeid", defaultValue = "-1") int contenttypeid, 
			@RequestParam(value="contentid", defaultValue = "-1") int contentid, 
			@RequestParam(value="eventstartdate", defaultValue = "-1") int eventstartdate, 
			@RequestParam(value="eventenddate", defaultValue = "-1") int eventenddate){	
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userno", userno);
		params.put("contenttypeid", contenttypeid);
		params.put("contentid", contentid);
		
		String startdate = String.valueOf(eventstartdate);
		String enddate = String.valueOf(eventenddate);
		
		if(-1 != eventstartdate) {
			startdate = startdate.substring(0, 4) + "-" + startdate.substring(4, 6) + "-" + startdate.substring(6);
		}else {
			startdate = null;
		}
		
		if(-1 != eventenddate) {
			enddate = enddate.substring(0, 4) + "-" + enddate.substring(4, 6) + "-" + enddate.substring(6);	
		} else {
			enddate = null;
		}
		
		params.put("eventstartdate", startdate);
		params.put("eventenddate", enddate);
		
		int response = service.insertFavorite(params);
		boolean result = false;
		if(response > 0) result = true;
		logger.info("insertFavorite.do : " + result);
		return result;
	}
	
	// 찜 삭제
	@RequestMapping(value = "deleteFavorite.do", method = RequestMethod.POST)
	public @ResponseBody boolean deleteFavorite(
			@RequestParam(value="userno", defaultValue = "-1") int userno, 
			@RequestParam(value="contenttypeid", defaultValue = "-1") int contenttypeid, 
			@RequestParam(value="contentid", defaultValue = "-1") int contentid){	
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("userno", userno);
		params.put("contenttypeid", contenttypeid);
		params.put("contentid", contentid);
		int response = service.deleteFavorite(params);
		boolean result = false;
		if(response > 0) result = true;
		logger.info("deleteFavorite.do : " + result);
		return result;
	}
}

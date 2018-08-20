package com.kh.planner.favorite.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public @ResponseBody boolean checkFavorite(int userno, int contentid, int contenttypeid){	
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("userno", userno);
		params.put("contentid", contentid);
		params.put("contenttypeid", contenttypeid);
		HashMap<String, Integer> response = service.checkFavorite(params);
		boolean result = false;
		logger.info(response.toString());
		if(response != null) result = true;
		return result;
	}
	
	// 찜 추가
	@RequestMapping(value = "insertFavorite.do", method = RequestMethod.POST)
	public @ResponseBody boolean insertFavorite(int userno, int contentid, int contenttypeid){	
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("userno", userno);
		params.put("contentid", contentid);
		params.put("contenttypeid", contenttypeid);
		int response = service.insertFavorite(params);
		boolean result = false;
		if(response > 0) result = true;
		return result;
	}
	
	// 찜 삭제
	@RequestMapping(value = "deleteFavorite.do", method = RequestMethod.POST)
	public @ResponseBody boolean deleteFavorite(int userno, int contentid, int contenttypeid){	
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("userno", userno);
		params.put("contentid", contentid);
		params.put("contenttypeid", contenttypeid);
		int response = service.deleteFavorite(params);
		boolean result = false;
		if(response > 0) result = true;
		return result;
	}
}

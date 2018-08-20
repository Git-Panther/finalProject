package com.kh.planner.favorite.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.planner.favorite.model.dao.FavoriteDao;

@Service
public class FavoriteService {
	@Autowired
	private FavoriteDao dao;
	
	public HashMap<String, Integer> checkFavorite(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return dao.checkFavorite(params);
	}

	public int insertFavorite(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return dao.insertFavorite(params);
	}

	public int deleteFavorite(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return dao.deleteFavorite(params);
	}

}

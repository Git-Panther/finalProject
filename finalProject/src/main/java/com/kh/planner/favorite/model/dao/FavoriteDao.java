package com.kh.planner.favorite.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FavoriteDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public HashMap<String, Integer> checkFavorite(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FavoriteMapper.checkFavorite", params);
	}

	public int insertFavorite(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return sqlSession.insert("FavoriteMapper.insertFavorite", params);
	}

	public int deleteFavorite(Map<String, Integer> params) {
		// TODO Auto-generated method stub
		return sqlSession.delete("FavoriteMapper.deleteFavorite", params);
	}
	
}

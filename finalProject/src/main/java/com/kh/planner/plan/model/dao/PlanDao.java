package com.kh.planner.plan.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class PlanDao {
    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<Map> selectFavoriteList(Map<String, Integer> params) {
        return sqlSession.selectList("PlanMapper.selectFavoriteList", params);
    }

    public List<Map> selectFavoriteHotel(Map<String, Integer> params) {
        return sqlSession.selectList("PlanHotelMapper.selectFavoriteHotel", params);
    }
}

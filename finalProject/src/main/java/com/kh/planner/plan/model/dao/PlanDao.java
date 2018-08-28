package com.kh.planner.plan.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.planner.member.model.vo.Member;
import com.kh.planner.plan.model.vo.Plan;

import java.util.HashMap;
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

	public List<HashMap<String, String>> selectPlanList(Member user) {
		return sqlSession.selectList("PlanMapper.selectPlanList", user);
	}

	public int insertPlan(Plan plan) {
		return sqlSession.insert("PlanMapper.insertPlan", plan);
	}

	public int deletePlan(Plan plan) {
		return sqlSession.delete("PlanMapper.deletePlan", plan);
	}
}

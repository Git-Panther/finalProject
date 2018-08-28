package com.kh.planner.plan.model.service;

import com.kh.planner.member.model.vo.Member;
import com.kh.planner.plan.model.dao.PlanDao;
import com.kh.planner.plan.model.vo.Plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PlanService {
    @Autowired
    PlanDao dao;
    public List<Map> selectFavoriteList(Map<String, Integer> params) {
        return dao.selectFavoriteList(params);
    }

    public List<Map> selectFavoriteHotel(Map<String, Integer> params) {
        return dao.selectFavoriteHotel(params);
    }

	public List<HashMap<String, String>> selectPlanList(Member user) {
		return dao.selectPlanList(user);
	}

	public int insertPlan(Plan plan) {
		
		return dao.insertPlan(plan);
	}

	public int deletePlan(Plan plan) {
		return dao.deletePlan(plan);
	}
}

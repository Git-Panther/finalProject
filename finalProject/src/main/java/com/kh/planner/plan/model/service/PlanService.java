package com.kh.planner.plan.model.service;

import com.kh.planner.plan.model.dao.PlanDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}

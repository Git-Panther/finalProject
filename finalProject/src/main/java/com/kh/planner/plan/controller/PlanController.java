package com.kh.planner.plan.controller;

import com.google.gson.Gson;
import com.kh.planner.plan.model.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class PlanController {
    @Autowired
    PlanService service;

    @RequestMapping(value = "plan.do")
	public String plan() {
		return "plan/plan";
	}

    @RequestMapping(value = "selectFavoriteList.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
    public @ResponseBody
    String selectFavoriteList(int userNo, int contentTypeId) {
        Map<String, Integer> params = new HashMap<String, Integer>();
        params.put("userNo", userNo);
        params.put("contentTypeId", contentTypeId);
        Gson gson = new Gson();
        HashMap<String, Object> result = new HashMap<String, Object>();
        result.put("list", service.selectFavoriteList(params));
        String json = gson.toJson(result);

        return json;
    }
    @RequestMapping(value = "selectFavoriteHotel.do", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public @ResponseBody
    String selectFavoriteHotel(int userNo, int contentTypeId){
        Map<String, Integer> params = new HashMap<String, Integer>();
        params.put("userNo", userNo);
        params.put("contentTypeId", contentTypeId);
        Gson gson = new Gson();
        HashMap<String, Object> result = new HashMap<String, Object>();
        result.put("list", service.selectFavoriteHotel(params));
        String json = gson.toJson(result);

        return json;
    }

}

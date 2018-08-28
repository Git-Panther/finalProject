package com.kh.planner.plan.controller;

import com.google.gson.Gson;
import com.kh.planner.member.model.vo.Member;
import com.kh.planner.plan.model.service.PlanService;
import com.kh.planner.plan.model.vo.Plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Controller
public class PlanController {
    @Autowired
    PlanService service;

    @RequestMapping(value = "plan.do")
	public ModelAndView plan(HttpSession session, ModelAndView mv) {
    	Member user = (Member)session.getAttribute("user");
    	
    	List<HashMap<String, String>> planList = service.selectPlanList(user);
    	System.out.println("test" + planList);
    	mv.addObject("list", planList);
    	mv.setViewName("plan/plan");
		return mv;
	}
    
    @RequestMapping(value = "insertFavorite.do")
	public ModelAndView insertFavorite(HttpSession session, ModelAndView mv) {
    	Member user = (Member)session.getAttribute("user");
    	
    	List<HashMap<String, String>> planList = service.selectPlanList(user);
    	System.out.println("test" + planList);
    	mv.addObject("list", planList);
    	mv.setViewName("plan/plan");
		return mv;
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
    
    @RequestMapping("insertPlan.do")
    public String insertPlan(HttpSession session, Plan plan){
    	Member user = (Member)session.getAttribute("user");
    	plan.setUserno(user.getUserNo());
    	
    	System.out.println(plan);
    	int result = service.insertPlan(plan);
    	
    	
    	return "redirect:plan.do";
    }

    @RequestMapping("deletePlan.do")
    public String deletePlan(HttpSession session, Plan plan){
    	Member user = (Member)session.getAttribute("user");
    	plan.setUserno(user.getUserNo());
    	
    	System.out.println(plan);
    	int result = service.deletePlan(plan);
    	
    	return "redirect:plan.do";
    }
    
}

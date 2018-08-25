package com.kh.planner.review.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.planner.review.model.service.ReviewService;
import com.kh.planner.review.model.vo.Review;

@Controller
public class ReviewController {
	@Autowired
	ReviewService service;
	
	@RequestMapping("selectReview.do")
	public @ResponseBody Map<String, Object> selectReview(Review review){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Review> list = service.selectReviewAll(review);
		
		resultMap.put("list", list);
		
		return resultMap;
	}
	
	@RequestMapping("writeReview.do")
	public @ResponseBody Map<String, Object> writeReview(Review review){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		System.out.println(review);
		int result = service.insertReview(review);
		
		List<Review> list = service.selectReviewAll(review);
		
		resultMap.put("result", result);
		resultMap.put("list", list);
		
		return resultMap;
	}

	@RequestMapping("deleteReview.do")
	public @ResponseBody Map<String, Object> deleteReview(Review review){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = service.deleteReview(review);
		
		List<Review> list = service.selectReviewAll(review);
		
		resultMap.put("result", result);
		resultMap.put("list", list);
		
		return resultMap;
	}
	
	
	@RequestMapping("updateReview.do")
	public @ResponseBody Map<String, Object> updateReview(Review review){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = service.updateReview(review);
		
		List<Review> list = service.selectReviewAll(review);
		
		resultMap.put("result", result);
		resultMap.put("list", list);
		
		return resultMap;
	}
	
}

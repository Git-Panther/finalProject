package com.kh.planner.review.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.planner.review.model.dao.ReviewDao;
import com.kh.planner.review.model.vo.Review;

@Service
public class ReviewService {

	@Autowired
	ReviewDao dao;
	
	public int insertReview(Review review) {
		return dao.insertReview(review);
	}

	public List<Review> selectReviewAll(Review review) {
		return dao.selectReviewAll(review);
	}

	public int deleteReview(Review review) {
		return dao.deleteReview(review);
	}

	public int updateReview(Review review) {
		return dao.updateReview(review);
	}

	public List<Review> selectMyReview(Review review) {
		return dao.selectMyReview(review);
	}

	public List<Review> selectAdminReviewList(String userNo) {
		// TODO Auto-generated method stub
		return dao.selectAdminReviewList(userNo);
	}

}

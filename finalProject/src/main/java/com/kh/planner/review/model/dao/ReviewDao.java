package com.kh.planner.review.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.planner.review.model.vo.Review;

@Repository
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertReview(Review review) {
		return sqlSession.insert("ReviewMapper.insertReview", review);
	}

	public List<Review> selectReviewAll(Review review) {
		return sqlSession.selectList("ReviewMapper.selectReviewAll", review);
	}

	public int deleteReview(Review review) {
		return sqlSession.delete("ReviewMapper.deleteReview", review);
	}

	public int updateReview(Review review) {
		return sqlSession.update("ReviewMapper.updateReview", review);
	}

	public List<Review> selectMyReview(Review review) {
		return sqlSession.selectList("ReviewMapper.selectMyReview", review);
	}

}

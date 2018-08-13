package com.kh.planner.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.planner.member.model.vo.Member;

@Repository
public class MemberDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	public Member selectMember(Member member) {
		return sqlSession.selectOne("MemberMapper.selectMemberId", member);
	}

}

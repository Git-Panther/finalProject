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
	
	public int insertMember (Member member) {
		return sqlSession.insert("MemberMapper.insertMember", member);
	}

	public int deleteMember(Member user) {
		return sqlSession.delete("MemberMapper.deleteMember", user);
	}

	public int updatePassword(Member user) {
		return sqlSession.update("MemberMapper.updatePassword", user);
	}

	public int updateMember(Member member) {
		return sqlSession.update("MemberMapper.updateMember", member);
	}

}

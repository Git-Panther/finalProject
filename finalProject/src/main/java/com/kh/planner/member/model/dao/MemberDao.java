package com.kh.planner.member.model.dao;

import java.util.List;

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

	public List<Member> selectAdminMemberList() {
		return sqlSession.selectList("MemberMapper.selectAdminMemberList");
	}

}

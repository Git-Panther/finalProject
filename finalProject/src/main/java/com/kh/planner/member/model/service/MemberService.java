package com.kh.planner.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.planner.member.model.dao.MemberDao;
import com.kh.planner.member.model.vo.Member;

@Service
public class MemberService {
		@Autowired
		MemberDao dao;
		
		public Member selectMember(Member member){
			return dao.selectMember(member);
		}

}

package com.kh.planner.member.model.service;
import java.util.List;

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

		public int insertMember(Member member){
			return dao.insertMember(member);
		}

		public int deleteMember(Member member) {
			return dao.deleteMember(member);
		}

		public int updatePassword(Member member) {
			return dao.updatePassword(member);
		}

		public int updateMember(Member member) {
			return dao.updateMember(member);
		}
		public List<Member> selectAdminMemberList() {
			return dao.selectAdminMemberList();
		}

		public int updateReviewYn(Member member) {
			return dao.updateReviewYn(member);
		}
}

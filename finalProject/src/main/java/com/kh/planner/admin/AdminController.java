package com.kh.planner.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.planner.member.model.service.MemberService;
import com.kh.planner.member.model.vo.Member;

@Controller
public class AdminController {
	@Autowired
	MemberService memberService;
	
	@RequestMapping("adminMain.do")
	public String adminMainPage(){
		return "admin/adminMain";
	}
	
	@RequestMapping("adminreview.do")
	public ModelAndView adminMainPage(ModelAndView mv){
		
		List<Member> mlist = memberService.selectAdminMemberList(); 
		System.out.println(mlist);
		mv.addObject("mlist", mlist);
		mv.setViewName("admin/adminMember");
		return mv;
	}

	@RequestMapping("updateReviewYn.do")
	public String updateReviewYn(Member member){
		
		int result = memberService.updateReviewYn(member); 
		return "redirect:adminreview.do";
	}

	@RequestMapping("deleteMember.do")
	public String deleteMember(Member member){
		
		int result = memberService.deleteMember(member); 
		return "redirect:adminreview.do";
	}
	
	
}

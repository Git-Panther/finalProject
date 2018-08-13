package com.kh.planner.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.planner.member.model.service.MemberService;
import com.kh.planner.member.model.vo.Member;

@Controller
public class MemberController{
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(Member member, HttpSession session){
		Member user = memberService.selectMember(member);
		System.out.println(user);
		if(null != user && user.getPassword().equals(member.getPassword())){
			session.setAttribute("user", user);
		}else{
			System.out.println("비밀번호가 일치하지 않습니다");
		}
		 return "index";
	}
	
	@RequestMapping(value = "loginPage.do", method = RequestMethod.GET)
	public String memberJoinForm() {
		return "member/loginPage";
	}
	
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:index.do";
	}
}
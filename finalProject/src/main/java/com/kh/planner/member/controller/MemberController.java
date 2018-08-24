package com.kh.planner.member.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.planner.member.model.service.MemberService;
import com.kh.planner.member.model.vo.Member;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;

	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String login(Member member, HttpSession session) {
		Member user = memberService.selectMember(member);
		if (null != user && user.getPassword().equals(member.getPassword())) {
			session.setAttribute("user", user);
			return "redirect:index.do";
		} else {
			return "redirect:loginPage.do";
		}
		
	}

	@RequestMapping(value = "loginPage.do", method = RequestMethod.GET)
	public String memberLoginForm() {
		return "member/loginPage";
	}

	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:index.do";
	}

	@RequestMapping(value = "joinPage.do", method = RequestMethod.GET)
	public String memberJoinForm() {
		return "member/joinPage";
	}

	@RequestMapping(value="userIdCheck.do", method=RequestMethod.POST)
	public @ResponseBody String userIdCheck(String id){
		Member member = new Member();
		member.setUserId(id);
		Member user = memberService.selectMember(member);
		String result="";
		
		if(null != user){
			result="unavailable";
		}else{
			result="available";
		}
		return result;
	}
	@RequestMapping(value = "join.do")
	public String memberJoin(Member member, @RequestParam(value="profilePic1", required=false) MultipartFile file, HttpServletRequest request){
		
		if(file.getOriginalFilename().equals("") || file == null) {
			member.setProfilePic("default-profile.png");
		} else {
			String root = request.getSession().getServletContext().getRealPath("resources");
			
			String path = root + "\\upload";
			String filePath = "";
			File folder = new File(path);
			if(!folder.exists()){
				folder.mkdirs();
			}
			filePath = folder + "\\" + file.getOriginalFilename();
			try {
				file.transferTo(new File(filePath));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			member.setProfilePic(file.getOriginalFilename());
		}
		String view = "redirect:index.do";
		try{
			int result = memberService.insertMember(member);
		}catch(Exception e){
			view = "error";
		}
		return view;
	}
	
	@RequestMapping(value="memberInfo.do")
	public String memberInfo(HttpSession session){
		return "member/memberInfoPage";
	}
	
	@RequestMapping(value="memberUpdate.do")
	public String memberUpdate(){
		return "redirect:memberInfo.do";
	}
}
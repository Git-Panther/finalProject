package com.kh.planner.member.controller;

import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
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

	@RequestMapping(value = "userIdCheck.do", method = RequestMethod.POST)
	public @ResponseBody String userIdCheck(String id) {
		Member member = new Member();
		member.setUserId(id);
		Member user = memberService.selectMember(member);
		String result = "";

		if (null != user) {
			result = "unavailable";
		} else {
			result = "available";
		}
		return result;
	}

	@RequestMapping(value = "join.do")
	public String memberJoin(Member member, @RequestParam(value = "profilePic1", required = false) MultipartFile file,
			HttpServletRequest request) {

		if (file.getOriginalFilename().equals("") || file == null) {
			member.setProfilePic("default-profile.png");
		} else {
			String root = request.getSession().getServletContext().getRealPath("resources");

			String path = root + "\\upload";
			String filePath = "";
			File folder = new File(path);
			if (!folder.exists()) {
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
		String view = "member/joinSuccessPage";
		try {
			memberService.insertMember(member);
		} catch (Exception e) {
			view = "member/joinFailPage";
		}
		return view;
	}

	@RequestMapping(value = "memberInfo.do")
	public String memberInfo(HttpSession session) {
		return "member/memberInfoPage";
	}

	@RequestMapping(value = "memberUpdate.do")
	public String memberUpdate() {
		return "redirect:memberInfo.do";
	}

	@RequestMapping(value = "memberDelete.do")
	public String memberDelete(Member member, HttpSession session) {
		Member user = (Member) session.getAttribute("user");
		int result = memberService.deleteMember(user);
		System.out.println(result);
		System.out.println(user);
		if (result != 0) {
			return "redirect:logout.do";
		} else {
			return "redirect:memberInfo.do";
		}
	}

	@RequestMapping(value = "changePwdPage.do")
	public String changePasswordPage() {
		return "member/changePwdPage";
	}

	@RequestMapping(value = "changePwd.do", method = RequestMethod.POST)
	public String changePassword(Member member, @RequestParam(value = "oldPassword", required = true) String oldPwd,
			@RequestParam(value = "password", required = true) String password, HttpSession session) {
		System.out.println("controller호출");
		Member user = (Member) session.getAttribute("user");
		String orgPwd = (String) user.getPassword();
		String result = "";
		System.out.println(oldPwd);
		System.out.println(orgPwd);
		if (oldPwd.equals(orgPwd)) {
			user.setPassword(password);
			int res = memberService.updatePassword(user);
			System.out.println(res);
			if (res != 0) {
				result = "redirect:memberInfo.do";
			}
		} else {
			result = "redirect:changePwdPage.do";
		}
		return result;
	}

	@RequestMapping(value = "updateMember.do")
	public String updateMember(Member member,
			@RequestParam(value = "newProfilePic", required = false) MultipartFile file, HttpServletRequest request) {
		if (file.getOriginalFilename().equals("") || file == null) {
			member.setProfilePic("default-profile.png");
		} else {
			String root = request.getSession().getServletContext().getRealPath("resources");

			String path = root + "\\upload";
			String filePath = "";
			File folder = new File(path);
			if (!folder.exists()) {
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
		String view = "member/memberInfoPage";
		try {
			memberService.updateMember(member);
		} catch (Exception e) {
			System.out.println("실패");
			System.out.println(e);
			view = "member/memberInfoPage";
		}
		return view;
	}
}
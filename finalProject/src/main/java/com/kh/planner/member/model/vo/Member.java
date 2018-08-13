package com.kh.planner.member.model.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class Member {
	private int userNo;
	private String userId;
	private String password;
	private String userName;
	private String gender;
	private String email;
	private Date birthday;
	private Date enrollDate;
	private String profilePic;
	
	public Member(){}

	public Member(int userNo, String userId, String password, String userName, String gender, String email,
			Date birthday, String profilePic) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.password = password;
		this.userName = userName;
		this.gender = gender;
		this.email = email;
		this.birthday = birthday;
		this.profilePic = profilePic;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}

	@Override
	public String toString() {
		return "Member [userNo=" + userNo + ", userId=" + userId + ", password=" + password + ", userName=" + userName
				+ ", gender=" + gender + ", email=" + email + ", birthday=" + birthday + ", enrollDate=" + enrollDate + ", profilePic=" + profilePic
				+ "]";
	}
	
}

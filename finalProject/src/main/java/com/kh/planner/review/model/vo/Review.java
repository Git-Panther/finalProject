package com.kh.planner.review.model.vo;

import java.sql.Date;

public class Review {
	 
    private int cno;
    private int contenttypeid;
    private int contentid;
    private String content;
    private int writer;
    private String writerNm;
    private Date reg_date;
    private int grade;
    private int reviewCnt;
    private String profilePic;
    
    
    public Review(){
    }
    
    public int getReviewCnt() {
		return reviewCnt;
	}




	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}




	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}

	public int getGrade() {
		return grade;
	}



	public void setGrade(int grade) {
		this.grade = grade;
	}



	public Review(int contentid) {
    	this.contentid = contentid;
	}

	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	
	public int getContenttypeid() {
		return this.contenttypeid;
	}
	public void setContenttypeid(int contenttypeid) {
		this.contenttypeid = contenttypeid;
	}
	
	public int getContentid() {
		return this.contentid;
	}
	public void setContentid(int contentid) {
		this.contentid = contentid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getWriter() {
		return writer;
	}

	public void setWriter(int writer) {
		this.writer = writer;
	}

	public String getWriterNm() {
		return writerNm;
	}

	public void setWriterNm(String writerNm) {
		this.writerNm = writerNm;
	}

	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "Review [cno=" + cno + ", contenttypeid=" + contenttypeid + ", contentid=" + contentid + ", content=" + content + ", writer=" + writer
				+ ", writerNm=" + writerNm + ", reg_date=" + reg_date + ", grade=" + grade + ", reviewCnt=" + reviewCnt
				+ "]";
	}
	
	

}

package com.kh.planner.review.model.vo;

import java.sql.Date;

public class Review {
	 
    private int cno;
    private String content_id;
    private String content;
    private int writer;
    private String writerNm;
    private Date reg_date;
    
    public Review(){
    }
	
    public Review(int contentid) {
    	content_id = String.valueOf(contentid);
	}

	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getContent_id() {
		return content_id;
	}
	public void setContent_id(String content_id) {
		this.content_id = content_id;
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
		return "Review [cno=" + cno + ", content_id=" + content_id + ", content=" + content + ", writer=" + writer
				+ ", reg_date=" + reg_date + "]";
	}

}
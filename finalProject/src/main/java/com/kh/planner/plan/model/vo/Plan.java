package com.kh.planner.plan.model.vo;

import org.springframework.stereotype.Component;

@Component
public class Plan {
	private int planno; 
	private int userno;
	private int calendarno;
	private String content;
	private String startdate;
	private String enddate;
	private int contenttypeid;
	private int contentid;
	
	public Plan(){}

	public int getPlanno() {
		return planno;
	}

	public void setPlanno(int planno) {
		this.planno = planno;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public int getCalendarno() {
		return calendarno;
	}

	public void setCalendarno(int calendarno) {
		this.calendarno = calendarno;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public int getContenttypeid() {
		return contenttypeid;
	}

	public void setContenttypeid(int contenttypeid) {
		this.contenttypeid = contenttypeid;
	}

	public int getContentid() {
		return contentid;
	}

	public void setContentid(int contentid) {
		this.contentid = contentid;
	}

	@Override
	public String toString() {
		return "Plan [planno=" + planno + ", userno=" + userno + ", calendarno=" + calendarno + ", content=" + content
				+ ", startdate=" + startdate + ", enddate=" + enddate + ", contenttypeid=" + contenttypeid
				+ ", contentid=" + contentid + "]";
	}
}

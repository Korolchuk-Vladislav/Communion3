package com.herokuapp.communion.models;

import java.util.Date;

public class Topic {
	private int topicid;
	private int userid;
	private int sectionid;
	private String title;
	private Date update;

	public int getTopicid() {
		return topicid;
	}

	public void setTopicid(int topicid) {
		this.topicid = topicid;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getSectionid() {
		return sectionid;
	}

	public void setSectionid(int sectionid) {
		this.sectionid = sectionid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getUpdate() {
		return update;
	}

	public void setUpdate(Date update) {
		this.update = update;
	}

	public Topic(int topicid, int userid, int sectionid, String title) {
		this.topicid = topicid;
		this.userid = userid;
		this.sectionid = sectionid;
		this.title = title;
		this.update = new Date();
	}
	public Topic(int topicid, int userid, int sectionid, String title,Date update) {
		this.topicid = topicid;
		this.userid = userid;
		this.sectionid = sectionid;
		this.title = title;
		this.update = update;
	}
}

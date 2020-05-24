package com.herokuapp.communion.models;

import java.util.Date;

public class Post {
	private int postid;
	private int userid;
	private int topicid;
	private String postName;
	private String post;
	private Date postDate;

    public Post(int postid, int userid, int topicid, String postName, String post, Date postDate) {
        this.postid = postid;
        this.userid = userid;
        this.topicid = topicid;
        this.postName = postName;
        this.post = post;
        this.postDate = postDate;
    }

    public Post(int postid, int userid, int topicid, String postName, String post) {
        this.postid = postid;
        this.userid = userid;
        this.topicid = topicid;
        this.postName = postName;
        this.post = post;
        this.postDate = new Date();
    }

    public int getPostid() {

        return postid;
    }

    public void setPostid(int postid) {
        this.postid = postid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getTopicid() {
        return topicid;
    }

    public void setTopicid(int topicid) {
        this.topicid = topicid;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }
}

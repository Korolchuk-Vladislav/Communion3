package com.herokuapp.communion.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Forum {
	@SerializedName("forumid")
    @Expose
    private int forumid;
    @SerializedName("userid")
    @Expose
    private int userid;
    @SerializedName("img")
    @Expose
    private String img;
	@SerializedName("title")
    @Expose
    private String title;
    @SerializedName("about")
    @Expose
	private String about;
	@SerializedName("public")
    @Expose
	private int isPublic;
	
	public Forum(){};
	
    public int getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(int isPublic) {
		this.isPublic = isPublic;
	}    
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
    public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}
	public int getForumid() {
		return forumid;
	}

	public Forum(int forumid, int userid, String title, String img, String about, int isPublic) {
		this.forumid = forumid;
		this.userid = userid;
		this.title = title;
		this.img = img;
		this.about = about;
		this.isPublic = isPublic;
	}
	
	public Forum(int userid, String title, String img, String about, int isPublic) {
		this.forumid = -1;
		this.userid = userid;
		this.title = title;
		this.img = img;
		this.about = about;
		this.isPublic = isPublic;
	}
	@Override
	public String toString() {
		return "Forum [" + (title != null ? "title=" + title + ", " : "")
				+ (about != null ? "about=" + about + ", " : "") +
				(img != null ? "img=" + img: "") + "]";
	}
}

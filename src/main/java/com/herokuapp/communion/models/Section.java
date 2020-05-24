package com.herokuapp.communion.models;

public class Section {
	private int sectionid;
	private int forumid;
	private String name;
	private int parent;

    public int getSectionid() {
        return sectionid;
    }

    public void setSectionid(int sectionid) {
        this.sectionid = sectionid;
    }

    public int getForumid() {
        return forumid;
    }

    public void setForumid(int forumid) {
        this.forumid = forumid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public Section(int sectionid, int forumid, String name, int parent) {
		this.sectionid = sectionid;
		this.forumid = forumid;

		this.parent = parent;
		this.name = name;
	}
}

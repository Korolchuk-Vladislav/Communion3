package com.herokuapp.communion.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class ForumUser {
    @SerializedName("forumId")
    @Expose
    private int forumId;
    @SerializedName("userId")
    @Expose
    private int userId;
    @SerializedName("roleId")
    @Expose
    private int roleId;

    public int getForumId() {
        return forumId;
    }

    public void setForumId(int forumId) {
        this.forumId = forumId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public ForumUser(int forumId, int userId, int roleId) {
        this.forumId = forumId;
        this.userId = userId;
        this.roleId = roleId;
    }
}

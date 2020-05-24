package com.herokuapp.communion.models;

import java.time.LocalDateTime;

public class Message {
	private int msgid;
	private int chatid;
	private int userid;
	private String msg;
	private LocalDateTime msgDate;
	
	public int getMsgid() {
		return msgid;
	}

	public int getChatid() {
		return chatid;
	}

	public int getUserid() {
		return userid;
	}

	public String getMsg() {
		return msg;
	}

	public LocalDateTime getMsgDate() {
		return msgDate;
	}

	public Message(int chatId, int userId, String msg, LocalDateTime msgDate){
		this.msgid = -1;
		this.chatid = chatId;
		this.userid = userId;
		this.msg = msg;
		this.msgDate = msgDate;
	}
	
	public Message(int msgid, int chatid, int userid, String msg, LocalDateTime msgDate) {
		this.msgid = msgid;
		this.chatid = chatid;
		this.userid = userid;
		this.msg = msg;
		this.msgDate = msgDate;
	}

	@Override
	public String toString() {
		return getMsgDate().toString() + ":" + getMsg();
	}
}

package com.reportManager.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "admin")
public class Admin implements Serializable {

	private static final long serialVersionUID = 8152553339963446896L;
	
	@Column(name = "userId")
	private String userId;
	@Column(name = "userCode")
	private String userCode;
	@Column(name = "password")
	private String password;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}

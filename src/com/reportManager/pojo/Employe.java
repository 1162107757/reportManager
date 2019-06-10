package com.reportManager.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "employe")
public class Employe implements Serializable {

	private static final long serialVersionUID = -5331678634338321401L;
	
	@Id
	@Column(name = "employeId")
	private String employeId;
	@Column(name = "employeName")
	private String employeName;
	@Column(name = "workNumber")
	private String workNumber;
	@Column(name = "password")
	private String password;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getEmployeId() {
		return employeId;
	}
	public void setEmployeId(String employeId) {
		this.employeId = employeId;
	}
	public String getEmployeName() {
		return employeName;
	}
	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}
	public String getWorkNumber() {
		return workNumber;
	}
	public void setWorkNumber(String workNumber) {
		this.workNumber = workNumber;
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

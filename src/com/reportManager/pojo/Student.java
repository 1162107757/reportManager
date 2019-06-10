package com.reportManager.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="student")
public class Student implements Serializable {

	private static final long serialVersionUID = -6758580703877921757L;
	
	@Id
	@Column(name = "studentId")
	private String studentId;
	@Column(name = "studentNumber")
	private String studentNumber;
	@Column(name = "name")
	private String name;
	@Column(name = "sex")
	private Integer sex;
	@Column(name = "gradeId")
	private String gradeId;
	@Column(name = "password")
	private String password;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getStudentNumber() {
		return studentNumber;
	}
	public void setStudentNumber(String studentNumber) {
		this.studentNumber = studentNumber;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getGradeId() {
		return gradeId;
	}
	public void setGradeId(String gradeId) {
		this.gradeId = gradeId;
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

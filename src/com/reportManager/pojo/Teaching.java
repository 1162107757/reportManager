package com.reportManager.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Table(name = "teaching")
public class Teaching {

	@Id
	@Column(name = "teachingId")
	private String teachingId;
	@Column(name = "employeId")
	private String employeId;
	@Column(name = "gradeId")
	private String gradeId;
	@Column(name = "courseId")
	private String courseId;
	@Column(name = "classTime")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
	private String classTime;
	@Column(name = "credits")
	private Integer credits;
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	@Column(name = "createTime")
	private Date createTime;
	
	public String getTeachingId() {
		return teachingId;
	}
	public void setTeachingId(String teachingId) {
		this.teachingId = teachingId;
	}
	public String getEmployeId() {
		return employeId;
	}
	public void setEmployeId(String employeId) {
		this.employeId = employeId;
	}
	public String getGradeId() {
		return gradeId;
	}
	public void setGradeId(String gradeId) {
		this.gradeId = gradeId;
	}
	public String getClassTime() {
		return classTime;
	}
	public void setClassTime(String classTime) {
		this.classTime = classTime;
	}
	public Integer getCredits() {
		return credits;
	}
	public void setCredits(Integer credits) {
		this.credits = credits;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}

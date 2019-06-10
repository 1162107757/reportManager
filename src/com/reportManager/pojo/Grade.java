package com.reportManager.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "grade")
public class Grade {

	@Id
	@Column(name = "gradeId")
	private String gradeId;
	@Column(name = "attrYear")
	private String attrYear;
	@Column(name = "gradeName")
	private String gradeName;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getGradeId() {
		return gradeId;
	}
	public void setGradeId(String gradeId) {
		this.gradeId = gradeId;
	}
	public String getAttrYear() {
		return attrYear;
	}
	public void setAttrYear(String attrYear) {
		this.attrYear = attrYear;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}

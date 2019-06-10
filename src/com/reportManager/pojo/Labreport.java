package com.reportManager.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "labreport")
public class Labreport {

	@Id
	@Column(name = "labreportId")
	private String labreportId;
	@Column(name = "gradeId")
	private String gradeId;
	@Column(name = "labreportName")
	private String labreportName;
	@Column(name = "fileUrl")
	private String fileUrl;
	@Column(name = "courseId")
	private String courseId;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getLabreportId() {
		return labreportId;
	}
	public void setLabreportId(String labreportId) {
		this.labreportId = labreportId;
	}
	public String getGradeId() {
		return gradeId;
	}
	public void setGradeId(String gradeId) {
		this.gradeId = gradeId;
	}
	public String getLabreportName() {
		return labreportName;
	}
	public void setLabreportName(String labreportName) {
		this.labreportName = labreportName;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}

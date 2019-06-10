package com.reportManager.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "labreport_Detail")
public class LabreportDetail {

	@Id
	@Column(name = "labreportDetailId")
	private String labreportDetailId;
	@Column(name = "labreportId")
	private String labreportId;
	@Column(name = "studentId")
	private String studentId;
	@Column(name = "fileUrl")
	private String fileUrl;
	@Column(name = "score")
	private Integer score;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getLabreportDetailId() {
		return labreportDetailId;
	}
	public void setLabreportDetailId(String labreportDetailId) {
		this.labreportDetailId = labreportDetailId;
	}
	public String getLabreportId() {
		return labreportId;
	}
	public void setLabreportId(String labreportId) {
		this.labreportId = labreportId;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}

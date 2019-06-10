package com.reportManager.pojo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "assignment_Detail")
public class AssignmentDetail {

	@Id
	@Column(name = "assignmentDetailId")
	private String assignmentDetailId;
	@Column(name = "assignmentId")
	private String assignmentId;
	@Column(name = "studentId")
	private String studentId;
	@Column(name = "fileUrl")
	private String fileUrl;
	@Column(name = "score")
	private Integer score;
	@Column(name = "createTime")
	private Date createTime;
	
	public String getAssignmentDetailId() {
		return assignmentDetailId;
	}
	public void setAssignmentDetailId(String assignmentDetailId) {
		this.assignmentDetailId = assignmentDetailId;
	}
	public String getAssignmentId() {
		return assignmentId;
	}
	public void setAssignmentId(String assignmentId) {
		this.assignmentId = assignmentId;
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

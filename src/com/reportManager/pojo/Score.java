package com.reportManager.pojo;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name = "score")
public class Score {

	@Id
	@Column(name = "scoreId")
	private String scoreId;
	@Column(name = "studentId")
	private String studentId;
	@Column(name = "addScore")
	private Integer addScore;
	@Column(name = "subScore")
	private Integer subScore;
	@Column(name = "courseId")
	private String courseId;
	@Column(name = "reasonContent")
	private Integer reasonContent;
	@Column(name = "createTime")
	private Date createTime;
	
	@Transient
	private List<String> studentIds;
	
	public List<String> getStudentIds() {
		return studentIds;
	}
	public void setStudentIds(List<String> studentIds) {
		this.studentIds = studentIds;
	}
	public String getScoreId() {
		return scoreId;
	}
	public void setScoreId(String scoreId) {
		this.scoreId = scoreId;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public Integer getAddScore() {
		return addScore;
	}
	public void setAddScore(Integer addScore) {
		this.addScore = addScore;
	}
	public Integer getSubScore() {
		return subScore;
	}
	public void setSubScore(Integer subScore) {
		this.subScore = subScore;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public Integer getReasonContent() {
		return reasonContent;
	}
	public void setReasonContent(Integer reasonContent) {
		this.reasonContent = reasonContent;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}

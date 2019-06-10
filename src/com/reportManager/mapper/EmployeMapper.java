package com.reportManager.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.reportManager.pojo.Assignment;
import com.reportManager.pojo.AssignmentDetail;
import com.reportManager.pojo.Employe;
import com.reportManager.pojo.Labreport;
import com.reportManager.pojo.LabreportDetail;
import com.reportManager.pojo.Score;
import com.reportManager.pojo.info.AssignmentDetailInfo;
import com.reportManager.pojo.info.AssignmentInfo;
import com.reportManager.pojo.info.LabreportDetailInfo;
import com.reportManager.pojo.info.LabreportInfo;

@Repository
public interface EmployeMapper {

	Employe getEmploye(@Param("userCode")String userCode, @Param("password")String password);

	void updatePassword(@Param("userCode")String workNumber, @Param("password")String password);

	List<Map<String, Object>> getAssignmentList(AssignmentInfo assignmentInfo);

	Integer getAssignmentListCount(AssignmentInfo assignmentInfo);

	void addAssignment(Assignment assignment);

	void updateAssignment(Assignment assignment);

	List<Map<String, Object>> getAssignmentDetailList(AssignmentDetailInfo assignmentDetailInfo);

	Integer getAssignmentDetailListCount(AssignmentDetailInfo assignmentDetailInfo);

	void updateScore(AssignmentDetail assignmentDetail);

	List<Map<String, Object>> getLabreportList(LabreportInfo labreportInfo);

	Integer getLabreportListCount(LabreportInfo labreportInfo);

	List<Map<String, Object>> getLabreportDetailList(LabreportDetailInfo labreportDetailInfo);

	Integer getLabreportDetailListCount(LabreportDetailInfo labreportDetailInfo);

	void updateLabreportScore(LabreportDetail labreportDetail);

	void addLabreport(Labreport labreport);

	void updateLabreport(Labreport labreport);

	List<Map<String, Object>> getEmployeGrade(String employeId);

	List<Map<String, Object>> getEmployeCourse(String gradeId);

	Score getScoreByStudentIdAndCourseId(Score score);

	void updateScoreTwo(Score score);

	void addScore(Score score);

}

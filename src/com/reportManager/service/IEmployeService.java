package com.reportManager.service;

import java.util.List;
import java.util.Map;

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
import com.reportManager.utils.PageHelper;

public interface IEmployeService {

	Employe login(String userCode, String password) throws Exception;

	void updatePassword(String workNumber, String origpassword, String newPassword);

	PageHelper getAssignmentList(AssignmentInfo assignmentInfo);

	void updateAssignment(Assignment assignment);

	PageHelper getAssignmentDetailList(AssignmentDetailInfo assignmentDetailInfo);

	void updateScore(AssignmentDetail assignmentDetail);

	PageHelper getLabreportList(LabreportInfo labreportInfo);

	PageHelper getLabreportDetailList(LabreportDetailInfo labreportDetailInfo);

	void updateLabreportScore(LabreportDetail labreportDetail);

	void updateLabreport(Labreport labreport);

	List<Map<String, Object>> getEmployeGrade(String employeId);

	List<Map<String, Object>> getEmployeCourse(String gradeId);

	void updateScoreTwo(Score score);

}

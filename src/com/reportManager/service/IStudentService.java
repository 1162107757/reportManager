package com.reportManager.service;


import com.reportManager.pojo.AssignmentDetail;
import com.reportManager.pojo.LabreportDetail;
import com.reportManager.pojo.Student;
import com.reportManager.pojo.info.StudentInfo;
import com.reportManager.utils.PageHelper;

public interface IStudentService  {

	Student login(String userCode, String password) throws Exception;

	void updatePassword(String name, String origpassword, String newPassword);

	void updateAssignment(AssignmentDetail assignmentDetail);

	void updateLabreport(LabreportDetail labreportDetail);

	PageHelper getLabreportAveList(StudentInfo studentInfo);

	PageHelper getAssignmentAveList(StudentInfo studentInfo);

	PageHelper getScoreByStudentId(StudentInfo studentInfo);

	PageHelper getFinalScoreByStudentId(StudentInfo studentInfo);

}

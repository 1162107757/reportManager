package com.reportManager.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.reportManager.pojo.AssignmentDetail;
import com.reportManager.pojo.LabreportDetail;
import com.reportManager.pojo.Student;
import com.reportManager.pojo.info.StudentInfo;

@Repository
public interface StudentMapper {

	Student getStudent(@Param("userCode")String userCode, @Param("password")String password);

	void updatePassword(@Param("userCode")String name, @Param("password")String password);

	void updateAssignment(AssignmentDetail assignmentDetail);

	void updateLabreport(LabreportDetail labreportDetail);

	AssignmentDetail getAssignmentDetailByStudentIdAndAssignmentId(AssignmentDetail assignmentDetail);

	LabreportDetail getLabreportDetailByStudentIdAndLabreportId(LabreportDetail labreportDetail);

	List<Map<String, Object>> getLabreportAveList(StudentInfo studentInfo);

	Integer getLabreportAveListCount(StudentInfo studentInfo);

	List<Map<String, Object>> getAssignmentAveList(StudentInfo studentInfo);

	Integer getAssignmentAveListCount(StudentInfo studentInfo);

	List<Map<String, Object>> getScoreByStudentId(StudentInfo studentInfo);

	Integer getScoreByStudentIdCount(StudentInfo studentInfo);

	List<Map<String, Object>> getGradeAllCourse(StudentInfo studentInfo);

}

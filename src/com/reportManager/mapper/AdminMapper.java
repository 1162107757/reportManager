package com.reportManager.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.reportManager.pojo.Admin;
import com.reportManager.pojo.Course;
import com.reportManager.pojo.Employe;
import com.reportManager.pojo.Grade;
import com.reportManager.pojo.Student;
import com.reportManager.pojo.Teaching;
import com.reportManager.pojo.info.CourseInfo;
import com.reportManager.pojo.info.EmployeInfo;
import com.reportManager.pojo.info.GradeInfo;
import com.reportManager.pojo.info.StudentInfo;
import com.reportManager.pojo.info.TeachingInfo;

@Repository
public interface AdminMapper {

	Admin getAdmin(@Param("userCode")String userCode, @Param("password")String password);

	void updatePassword(@Param("userCode") String userCode, @Param("password") String password);

	List<Map<String, Object>> getStudentList(StudentInfo studentInfo);

	Integer getStudentListCount(StudentInfo studentInfo);

	void updateStudent(Student student);

	List<Map<String, Object>> getGradeList(GradeInfo gradeInfo);

	Integer getgGradeListCount(GradeInfo gradeInfo);

	List<Map<String, Object>> getEmployeList(EmployeInfo employeInfo);

	Integer getEmployeListCount(EmployeInfo employeInfo);

	void updateEmploye(Employe employe);

	void updateGrade(Grade grade);

	List<Map<String, Object>> getCourseList(CourseInfo courseInfo);

	Integer getCourseListCount(CourseInfo courseInfo);

	void updateCourse(Course course);

	List<Map<String, Object>> getTeachingList(TeachingInfo teachingInfo);

	Integer getTeachingListCount(TeachingInfo teachingInfo);

	void updateTeaching(Teaching teaching);

	void addCourse(Course course);

	void addEmploye(Employe employe);

	void addStudent(Student student);

	void addGrade(Grade grade);

	void addTeaching(Teaching teaching);

	Teaching getTeachingByCourseNameAndGradeName(Teaching teaching);

	Student getStudentByStudentNumber(String studentNumber);

	Employe getEmployeByWorkNumber(String workNumber);
	
}

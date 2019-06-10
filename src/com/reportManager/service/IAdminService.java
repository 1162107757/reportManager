package com.reportManager.service;

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
import com.reportManager.utils.PageHelper;

public interface IAdminService {

	Admin login(String userCode, String password) throws Exception;

	void updatePassword(String userCode, String origpassword, String newPassword);

	PageHelper getStudentList(StudentInfo studentInfo);

	void updateStudent(Student student);

	PageHelper getGradeList(GradeInfo gradeInfo);

	PageHelper getEmployeList(EmployeInfo employeInfo);

	void updateEmploye(Employe employe);

	void updateGrade(Grade grade);

	PageHelper getCourseList(CourseInfo courseInfo);

	void updateCourse(Course course);

	PageHelper getTeachingList(TeachingInfo teachingInfo);

	void updateTeaching(Teaching teaching);

}

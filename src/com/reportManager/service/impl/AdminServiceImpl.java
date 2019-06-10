package com.reportManager.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.reportManager.mapper.AdminMapper;
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
import com.reportManager.service.IAdminService;
import com.reportManager.utils.MD5Util;
import com.reportManager.utils.PageHelper;

@Service("adminService")
public class AdminServiceImpl implements IAdminService {
	
	@Resource
	private AdminMapper adminMapper;

	@Override
	public Admin login(String userCode, String password) throws Exception {
		if(!StringUtils.isNotBlank(userCode)){
			throw new RuntimeException("请输入用户名！");
		}
		if(!StringUtils.isNotBlank(password)){
			throw new RuntimeException("请输入密码！");
		}
		Admin admin = adminMapper.getAdmin(userCode, MD5Util.getMd5(password));
		if(admin == null){
			throw new RuntimeException("用户不存在或密码错误！");
		}
		return admin;
	}

	@Override
	public void updatePassword(String userCode, String origpassword, String newPassword) {
		if(!StringUtils.isNotBlank(origpassword)){
			throw new RuntimeException("请输入密码！");
		}
		if(!StringUtils.isNotBlank(newPassword)){
			throw new RuntimeException("请输入新密码！");
		}
		Admin admin = adminMapper.getAdmin(userCode, MD5Util.getMd5(origpassword));
		if(admin == null){
			throw new RuntimeException("原密码输入错误！");
		}
		// 更新密码
		adminMapper.updatePassword(userCode, MD5Util.getMd5(newPassword));
	}

	@Override
	public PageHelper getStudentList(StudentInfo studentInfo) {
		studentInfo.setPage((studentInfo.getPage() - 1) * studentInfo.getLimit());
		List<Map<String, Object>> students = adminMapper.getStudentList(studentInfo);
		if(StringUtils.isNotBlank(studentInfo.getGradeId())){
			for (Map<String, Object> map : students) {
				if(map.get("addScore") == null){
					map.put("addScore", 60);
				}
				if(map.get("subScore") == null){
					map.put("subScore", 100);
				}
			}
		}
		Integer count = adminMapper.getStudentListCount(studentInfo);
		return new PageHelper(count, students);
	}

	@Override
	public void updateStudent(Student student) {
		if(StringUtils.isBlank(student.getName())){
			throw new RuntimeException("请填写学生名字！");
		}
		if(student.getSex() == null){
			throw new RuntimeException("请填写学生性别！");
		}
		if(student.getStudentNumber() == null){
			throw new RuntimeException("请填写学号！");
		}
		if(StringUtils.isBlank(student.getStudentId())){
			student.setStudentId(UUID.randomUUID().toString());
			// 通过学号查询学生是否存在
			Student studentdb = adminMapper.getStudentByStudentNumber(student.getStudentNumber());
			if(studentdb != null){
				throw new RuntimeException("学号已存在，请重新填写！");
			}
			
			adminMapper.addStudent(student);
		}else{
			adminMapper.updateStudent(student);
		}
	}

	@Override
	public PageHelper getGradeList(GradeInfo gradeInfo) {
		gradeInfo.setPage((gradeInfo.getPage() - 1) * gradeInfo.getLimit());
		List<Map<String, Object>> courses = adminMapper.getGradeList(gradeInfo);
		Integer count = adminMapper.getgGradeListCount(gradeInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public PageHelper getEmployeList(EmployeInfo employeInfo) {
		employeInfo.setPage((employeInfo.getPage() - 1) * employeInfo.getLimit());
		List<Map<String, Object>> courses = adminMapper.getEmployeList(employeInfo);
		Integer count = adminMapper.getEmployeListCount(employeInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public void updateEmploye(Employe employe) {
		if(StringUtils.isBlank(employe.getEmployeName())){
			throw new RuntimeException("请填写教师名字！");
		}
		if(StringUtils.isBlank(employe.getWorkNumber())){
			throw new RuntimeException("请填写教师工号！");
		}
		if(StringUtils.isBlank(employe.getEmployeId())){
			// 通过工号查询教师是否已存在
			Employe employedb = adminMapper.getEmployeByWorkNumber(employe.getWorkNumber());
			if(employedb != null){
				throw new RuntimeException("工号已存在，请重新填写！");
			}
			employe.setEmployeId(UUID.randomUUID().toString());
			adminMapper.addEmploye(employe);
		}else{
			adminMapper.updateEmploye(employe);
		}
	}

	@Override
	public void updateGrade(Grade grade) {
		if(StringUtils.isBlank(grade.getGradeName())){
			throw new RuntimeException("请填写班级名称！");
		}
		if(StringUtils.isBlank(grade.getAttrYear())){
			throw new RuntimeException("请填写年份！");
		}
		if(StringUtils.isBlank(grade.getGradeId())){
			grade.setGradeId(UUID.randomUUID().toString());
			adminMapper.addGrade(grade);
		}else{
			adminMapper.updateGrade(grade);
		}
	}

	@Override
	public PageHelper getCourseList(CourseInfo courseInfo) {
		courseInfo.setPage((courseInfo.getPage() - 1) * courseInfo.getLimit());
		List<Map<String, Object>> courses = adminMapper.getCourseList(courseInfo);
		Integer count = adminMapper.getCourseListCount(courseInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public void updateCourse(Course course) {
		if(StringUtils.isBlank(course.getCourseName())){
			throw new RuntimeException("请填写课程名称！");
		}
		if(StringUtils.isBlank(course.getCourseId())){
			course.setCourseId(UUID.randomUUID().toString());
			adminMapper.addCourse(course);
		}else{
			adminMapper.updateCourse(course);
		}
	}

	@Override
	public PageHelper getTeachingList(TeachingInfo teachingInfo) {
		teachingInfo.setPage((teachingInfo.getPage() - 1) * teachingInfo.getLimit());
		List<Map<String, Object>> teachings = adminMapper.getTeachingList(teachingInfo);
		Integer count = adminMapper.getTeachingListCount(teachingInfo);
		return new PageHelper(count, teachings);
	}

	@Override
	public void updateTeaching(Teaching teaching) {
		if(teaching.getClassTime() == null){
			throw new RuntimeException("请填写上课时间！");
		}
		if(StringUtils.isBlank(teaching.getTeachingId())){
			Teaching teachingdb = adminMapper.getTeachingByCourseNameAndGradeName(teaching);
			if(teachingdb != null){
				throw new RuntimeException("被授权教师已存在班级与名称相同的记录！");
			}
			teaching.setTeachingId(UUID.randomUUID().toString());
			adminMapper.addTeaching(teaching);
		}else{
			adminMapper.updateTeaching(teaching);
		}
	}
	
}

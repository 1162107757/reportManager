package com.reportManager.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.reportManager.mapper.StudentMapper;
import com.reportManager.pojo.AssignmentDetail;
import com.reportManager.pojo.Employe;
import com.reportManager.pojo.LabreportDetail;
import com.reportManager.pojo.Student;
import com.reportManager.pojo.info.StudentInfo;
import com.reportManager.service.IStudentService;
import com.reportManager.utils.MD5Util;
import com.reportManager.utils.PageHelper;

@Service
public class StudentServiceImpl implements IStudentService {

	@Resource
	private StudentMapper studentMapper;
	
	@Override
	public Student login(String userCode, String password) throws Exception {
		if(!StringUtils.isNotBlank(userCode)){
			throw new RuntimeException("�������û�����");
		}
		if(!StringUtils.isNotBlank(password)){
			throw new RuntimeException("���������룡");
		}
		Student student = studentMapper.getStudent(userCode, MD5Util.getMd5(password));
		if(student == null){
			throw new RuntimeException("�û������ڻ��������");
		}
		return student;
	}

	@Override
	public void updatePassword(String name, String origpassword, String newPassword) {
		if(!StringUtils.isNotBlank(origpassword)){
			throw new RuntimeException("���������룡");
		}
		if(!StringUtils.isNotBlank(newPassword)){
			throw new RuntimeException("�����������룡");
		}
		Student student = studentMapper.getStudent(name, MD5Util.getMd5(origpassword));
		if(student == null){
			throw new RuntimeException("ԭ�����������");
		}
		// ��������
		studentMapper.updatePassword(name, MD5Util.getMd5(newPassword));
	}

	@Override
	public void updateAssignment(AssignmentDetail assignmentDetail) {
		if(StringUtils.isBlank(assignmentDetail.getFileUrl())){
			throw new RuntimeException("�����ϴ���ҵ������");
		}
		// ��ѯ�Ƿ��Ѿ��ύ������
		AssignmentDetail assignmentDetail2db = studentMapper.getAssignmentDetailByStudentIdAndAssignmentId(assignmentDetail);
		if(assignmentDetail2db != null){
			throw new RuntimeException("���Ѿ��ϴ�����ҵ�����������ٴ��ϴ���");
		}
		assignmentDetail.setAssignmentDetailId(UUID.randomUUID().toString());
		studentMapper.updateAssignment(assignmentDetail);
	}

	@Override
	public void updateLabreport(LabreportDetail labreportDetail) {
		if(StringUtils.isBlank(labreportDetail.getFileUrl())){
			throw new RuntimeException("�����ϴ����渽����");
		}
		LabreportDetail labreportDetaildb = studentMapper.getLabreportDetailByStudentIdAndLabreportId(labreportDetail);
		if(labreportDetaildb != null){
			throw new RuntimeException("���Ѿ��ϴ������渽���������ٴ��ϴ���");
		}
		labreportDetail.setLabreportDetailId(UUID.randomUUID().toString());
		studentMapper.updateLabreport(labreportDetail);
	}

	@Override
	public PageHelper getLabreportAveList(StudentInfo studentInfo) {
		studentInfo.setPage((studentInfo.getPage() - 1) * studentInfo.getLimit());
		List<Map<String, Object>> courses = studentMapper.getLabreportAveList(studentInfo);
		Integer count = studentMapper.getLabreportAveListCount(studentInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public PageHelper getAssignmentAveList(StudentInfo studentInfo) {
		studentInfo.setPage((studentInfo.getPage() - 1) * studentInfo.getLimit());
		List<Map<String, Object>> courses = studentMapper.getAssignmentAveList(studentInfo);
		Integer count = studentMapper.getAssignmentAveListCount(studentInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public PageHelper getScoreByStudentId(StudentInfo studentInfo) {
		studentInfo.setPage((studentInfo.getPage() - 1) * studentInfo.getLimit());
		List<Map<String, Object>> courses = studentMapper.getScoreByStudentId(studentInfo);
		for (Map<String, Object> map : courses) {
			if(map.get("addScore") == null){
				map.put("addScore", 60);
			}
			if(map.get("subScore") == null){
				map.put("subScore",100);
			}
		}
		Integer count = studentMapper.getScoreByStudentIdCount(studentInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public PageHelper getFinalScoreByStudentId(StudentInfo studentInfo) {
		studentInfo.setPage((studentInfo.getPage() - 1) * studentInfo.getLimit());
		// ����༶���пγ�
		List<Map<String, Object>> courseList = studentMapper.getGradeAllCourse(studentInfo);
		List<Map<String, Object>> courses = studentMapper.getScoreByStudentId(studentInfo);
		List<Map<String, Object>> assignmentAve = studentMapper.getAssignmentAveList(studentInfo);
		List<Map<String, Object>> labreportAve = studentMapper.getLabreportAveList(studentInfo);
		Integer count = studentMapper.getScoreByStudentIdCount(studentInfo);
		// ����ƽʱ��
		for (Map<String, Object> map : courses) {
			if(map.get("addScore") == null){
				map.put("addScore", 60);
			}
			if(map.get("subScore") == null){
				map.put("subScore",100);
			}
		}
		// ����ƽʱ��
		for (Map<String, Object> allScore : courseList) {
			for (Map<String, Object> score : courses) {
				if(allScore.get("courseId").equals(score.get("courseId"))){
					allScore.put("allScore", new BigDecimal(score.get("addScore").toString()).add(new BigDecimal(score.get("subScore").toString())));
				}
			}
		}
		// ������ҵ��
		for (Map<String, Object> allScore : courseList) {
			for (Map<String, Object> assignment : assignmentAve) {
				if(allScore.get("courseId").toString().equals(assignment.get("courseId").toString())){
					allScore.put("allScore", new BigDecimal(allScore.get("allScore").toString()).add(new BigDecimal(assignment.get("avgScore").toString())));
				}
			}
		}
		// �������
		for (Map<String, Object> allScore : courseList) {
			for (Map<String, Object> labreport : labreportAve) {
				if(allScore.get("courseId").toString().equals(labreport.get("courseId").toString())){
					allScore.put("allScore", new BigDecimal(allScore.get("allScore").toString()).add(new BigDecimal(labreport.get("avgScore").toString())));
				}
			}
		}
		// ���з���/4
		for (Map<String, Object> allScore : courseList) {
			if(!allScore.get("allScore").toString().equals("0")){
				allScore.put("allScore", new BigDecimal(allScore.get("allScore").toString()).divide(new BigDecimal("4")));
			}
		}
		return new PageHelper(count, courseList);
	}

}

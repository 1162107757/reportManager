package com.reportManager.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.reportManager.mapper.EmployeMapper;
import com.reportManager.pojo.Admin;
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
import com.reportManager.service.IEmployeService;
import com.reportManager.utils.MD5Util;
import com.reportManager.utils.PageHelper;

@Service
public class EmployeServiceImpl implements IEmployeService {

	@Resource
	private EmployeMapper employeMapper;

	@Override
	public Employe login(String userCode, String password) throws Exception {
		if(!StringUtils.isNotBlank(userCode)){
			throw new RuntimeException("�������û�����");
		}
		if(!StringUtils.isNotBlank(password)){
			throw new RuntimeException("���������룡");
		}
		Employe employe = employeMapper.getEmploye(userCode, MD5Util.getMd5(password));
		if(employe == null){
			throw new RuntimeException("�û������ڻ��������");
		}
		return employe;
	}

	@Override
	public void updatePassword(String workNumber, String origpassword, String newPassword) {
		if(!StringUtils.isNotBlank(origpassword)){
			throw new RuntimeException("���������룡");
		}
		if(!StringUtils.isNotBlank(newPassword)){
			throw new RuntimeException("�����������룡");
		}
		Employe employe = employeMapper.getEmploye(workNumber, MD5Util.getMd5(origpassword));
		if(employe == null){
			throw new RuntimeException("ԭ�����������");
		}
		// ��������
		employeMapper.updatePassword(workNumber, MD5Util.getMd5(newPassword));
	}

	@Override
	public PageHelper getAssignmentList(AssignmentInfo assignmentInfo) {
		assignmentInfo.setPage((assignmentInfo.getPage() - 1) * assignmentInfo.getLimit());
		List<Map<String, Object>> courses = employeMapper.getAssignmentList(assignmentInfo);
		Integer count = employeMapper.getAssignmentListCount(assignmentInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public void updateAssignment(Assignment assignment) {
		if(StringUtils.isBlank(assignment.getAssignmentName())){
			throw new RuntimeException("����д��ҵ���ƣ�");
		}
		if(StringUtils.isBlank(assignment.getFileUrl())){
			throw new RuntimeException("�����ϴ���ҵ������");
		}
		if(StringUtils.isBlank(assignment.getAssignmentId())){
			assignment.setAssignmentId(UUID.randomUUID().toString());
			employeMapper.addAssignment(assignment);
		}else{
			employeMapper.updateAssignment(assignment);
		}
	}

	@Override
	public PageHelper getAssignmentDetailList(AssignmentDetailInfo assignmentDetailInfo) {
		assignmentDetailInfo.setPage((assignmentDetailInfo.getPage() - 1) * assignmentDetailInfo.getLimit());
		List<Map<String, Object>> courses = employeMapper.getAssignmentDetailList(assignmentDetailInfo);
		Integer count = employeMapper.getAssignmentDetailListCount(assignmentDetailInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public void updateScore(AssignmentDetail assignmentDetail) {
		if(assignmentDetail.getScore() == null){
			throw new RuntimeException("����д������");
		}
		if(assignmentDetail.getScore() < 0 || assignmentDetail.getScore() > 100){
			throw new RuntimeException("����д��ȷ�ķ�����Χ0-100��");
		}
		employeMapper.updateScore(assignmentDetail);
	}

	@Override
	public PageHelper getLabreportList(LabreportInfo labreportInfo) {
		labreportInfo.setPage((labreportInfo.getPage() - 1) * labreportInfo.getLimit());
		List<Map<String, Object>> courses = employeMapper.getLabreportList(labreportInfo);
		Integer count = employeMapper.getLabreportListCount(labreportInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public PageHelper getLabreportDetailList(LabreportDetailInfo labreportDetailInfo) {
		labreportDetailInfo.setPage((labreportDetailInfo.getPage() - 1) * labreportDetailInfo.getLimit());
		List<Map<String, Object>> courses = employeMapper.getLabreportDetailList(labreportDetailInfo);
		Integer count = employeMapper.getLabreportDetailListCount(labreportDetailInfo);
		return new PageHelper(count, courses);
	}

	@Override
	public void updateLabreportScore(LabreportDetail labreportDetail) {
		if(labreportDetail.getScore() == null){
			throw new RuntimeException("����д������");
		}
		if(labreportDetail.getScore() < 0 || labreportDetail.getScore() > 100){
			throw new RuntimeException("����д��ȷ�ķ�����Χ0-100��");
		}
		employeMapper.updateLabreportScore(labreportDetail);
	}

	@Override
	public void updateLabreport(Labreport labreport) {
		if(StringUtils.isBlank(labreport.getLabreportName())){
			throw new RuntimeException("����д�������ƣ�");
		}
		if(StringUtils.isBlank(labreport.getFileUrl())){
			throw new RuntimeException("�����ϴ���ҵ������");
		}
		if(StringUtils.isBlank(labreport.getLabreportId())){
			labreport.setLabreportId(UUID.randomUUID().toString());
			employeMapper.addLabreport(labreport);
		}else{
			employeMapper.updateLabreport(labreport);
		}
	}

	@Override
	public List<Map<String, Object>> getEmployeGrade(String employeId) {
		return employeMapper.getEmployeGrade(employeId);
	}

	@Override
	public List<Map<String, Object>> getEmployeCourse(String gradeId) {
		return employeMapper.getEmployeCourse(gradeId);
	}

	@Override
	public void updateScoreTwo(Score score) {
		// �Ȳ�ѯ
		Score scoredb = employeMapper.getScoreByStudentIdAndCourseId(score);
		if(scoredb != null){
			if(score.getReasonContent().equals(1)){
				if(!scoredb.getSubScore().equals(0)){
					scoredb.setSubScore(scoredb.getSubScore() - 10);
				}
			}else{
				if(!scoredb.getAddScore().equals(100)){
					scoredb.setAddScore(scoredb.getAddScore() + 10);
				}
			}
			employeMapper.updateScoreTwo(scoredb);
		}else{
			if(score.getReasonContent().equals(1)){
				score.setSubScore(90);
				score.setAddScore(60);
			}else{
				score.setAddScore(70);
				score.setSubScore(100);
			}
			score.setScoreId(UUID.randomUUID().toString());
			employeMapper.addScore(score);
		}
	}
	
}

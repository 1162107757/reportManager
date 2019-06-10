package com.reportManager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.reportManager.pojo.Admin;
import com.reportManager.pojo.AssignmentDetail;
import com.reportManager.pojo.Employe;
import com.reportManager.pojo.LabreportDetail;
import com.reportManager.pojo.Student;
import com.reportManager.pojo.info.AssignmentInfo;
import com.reportManager.pojo.info.LabreportInfo;
import com.reportManager.pojo.info.StudentInfo;
import com.reportManager.service.IEmployeService;
import com.reportManager.service.IStudentService;
import com.reportManager.utils.PageHelper;

@Controller
@RequestMapping("/student")
public class StudentController {
	
	@Resource
	private IStudentService studentService;

	@Resource
	private IEmployeService employeService;
	
	/**
	 * 访问学生登录系统
	 */
	@RequestMapping
	public String student(HttpServletRequest request, String type, String pageCode){
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			return "student/login";
		}else if(StringUtils.isNotBlank(type) && StringUtils.isNotBlank(pageCode)){
			return type + "/" + pageCode;
		}else {
			return "student/labreport";
		}
	}
	
	@RequestMapping("/login")
	public ResponseEntity<?> login(HttpServletRequest request,String userCode, String password){
		Map<String, Object> map = new HashMap<>();
		try {
			Student student = studentService.login(userCode, password);
			request.getSession().setAttribute("student", student);
			map.put("success", true);
			map.put("msg", "登陆成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@RequestMapping("/loginout")
	public String loginout(HttpServletRequest request,String type){
		request.getSession().removeAttribute("student");
		return type + "/login";
	}
	
	@PostMapping("/updatePassword")
	public ResponseEntity<?> updatePassword(HttpServletRequest request,String origpassword, String newPassword){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("success", false);
			map.put("msg", "登录超时，请重新登录！");
		}
		try {
			studentService.updatePassword(student.getName(), origpassword, newPassword);
			request.getSession().removeAttribute("student");
			map.put("success", true);
			map.put("msg", "修改成功，请重新登录！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@RequestMapping("/updateAssignment")
	public ResponseEntity<?> updateAssignment(@RequestBody AssignmentDetail assignmentDetail, HttpServletRequest request){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("success", false);
			map.put("msg", "登录超时，请重新登录！");
			return ResponseEntity.ok(map);
		}
		try {
			assignmentDetail.setStudentId(student.getStudentId());
			studentService.updateAssignment(assignmentDetail);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@RequestMapping("/updateLabreport")
	public ResponseEntity<?> updateLabreport(@RequestBody LabreportDetail labreportDetail, HttpServletRequest request){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("success", false);
			map.put("msg", "登录超时，请重新登录！");
			return ResponseEntity.ok(map);
		}
		try {
			labreportDetail.setStudentId(student.getStudentId());
			studentService.updateLabreport(labreportDetail);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	/**
	 * 获取各课程作业平均分
	 */
	@GetMapping("/getLabreportAveList")
	public ResponseEntity<?> getLabreportAveList(HttpServletRequest request,Integer page,Integer limit){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("data", null);
			map.put("count", 0);
			map.put("code", 0);
			return ResponseEntity.ok(map);
		}
		StudentInfo studentInfo = new StudentInfo();
		studentInfo.setPage(page);
		studentInfo.setLimit(limit);
		studentInfo.setStudentId(student.getStudentId());
		PageHelper info = studentService.getLabreportAveList(studentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getAssignmentList")
	public ResponseEntity<?> getAssignmentList(AssignmentInfo assignmentInfo, HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("data", null);
			map.put("count", 0);
			map.put("code", 0);
			return ResponseEntity.ok(map);
		}
		assignmentInfo.setStudentId(student.getStudentId());
		PageHelper info = employeService.getAssignmentList(assignmentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getLabreportList")
	public ResponseEntity<?> getLabreportList(LabreportInfo labreportInfo,HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("data", null);
			map.put("count", 0);
			map.put("code", 0);
			return ResponseEntity.ok(map);
		}
		labreportInfo.setStudentId(student.getStudentId());
		PageHelper info = employeService.getLabreportList(labreportInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	/**
	 * 获取各课程实验报告平均分
	 */
	@GetMapping("/getAssignmentAveList")
	public ResponseEntity<?> getAssignmentAveList(HttpServletRequest request,Integer page,Integer limit){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("data", null);
			map.put("count", 0);
			map.put("code", 0);
			return ResponseEntity.ok(map);
		}
		StudentInfo studentInfo = new StudentInfo();
		studentInfo.setPage(page);
		studentInfo.setLimit(limit);
		studentInfo.setStudentId(student.getStudentId());
		PageHelper info = studentService.getAssignmentAveList(studentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	/**
	 * 获取各课程平时表现分
	 */
	@GetMapping("/getScoreByStudentId")
	public ResponseEntity<?> getScoreByStudentId(HttpServletRequest request,Integer page,Integer limit){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("data", null);
			map.put("count", 0);
			map.put("code", 0);
			return ResponseEntity.ok(map);
		}
		StudentInfo studentInfo = new StudentInfo();
		studentInfo.setPage(page);
		studentInfo.setLimit(limit);
		studentInfo.setStudentId(student.getStudentId());
		PageHelper info = studentService.getScoreByStudentId(studentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	/**
	 * 获取各课程平时表现分
	 */
	@GetMapping("/getFinalScoreByStudentId")
	public ResponseEntity<?> getFinalScoreByStudentId(HttpServletRequest request,Integer page,Integer limit){
		Map<String, Object> map = new HashMap<>();
		Student student = (Student)request.getSession().getAttribute("student");
		if(student == null){
			map.put("data", null);
			map.put("count", 0);
			map.put("code", 0);
			return ResponseEntity.ok(map);
		}
		StudentInfo studentInfo = new StudentInfo();
		studentInfo.setPage(page);
		studentInfo.setLimit(limit);
		studentInfo.setStudentId(student.getStudentId());
		PageHelper info = studentService.getFinalScoreByStudentId(studentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
}

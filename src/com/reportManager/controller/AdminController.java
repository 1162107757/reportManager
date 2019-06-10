package com.reportManager.controller;

import java.util.HashMap;
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

import com.github.pagehelper.PageInfo;
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
import com.reportManager.utils.PageHelper;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Resource
	private IAdminService adminService;
	
	/**
	 * 访问管理员登录系统
	 */
	@RequestMapping
	public String admin(HttpServletRequest request, String type, String pageCode){
		Admin admin = (Admin)request.getSession().getAttribute("admin");
		if(admin == null){
			return "admin/login";
		}else if(StringUtils.isNotBlank(type) && StringUtils.isNotBlank(pageCode)){
			return type + "/" + pageCode;
		}else {
			return "admin/employeManager";
		}
	}

	/**
	 * 跳转管理员主页
	 * @throws Exception 
	 */
	@RequestMapping("/login")
	public ResponseEntity<?> login(HttpServletRequest request,String userCode, String password) throws Exception{
		Map<String, Object> map = new HashMap<>();
		try {
			Admin admin = adminService.login(userCode, password);
			request.getSession().setAttribute("admin", admin);
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
		request.getSession().removeAttribute("admin");
		return type + "/login";
	}
	
	@PostMapping("/updatePassword")
	public ResponseEntity<?> updatePassword(HttpServletRequest request,String origpassword, String newPassword){
		Map<String, Object> map = new HashMap<>();
		Admin admin = (Admin)request.getSession().getAttribute("admin");
		if(admin == null){
			map.put("success", false);
			map.put("msg", "登录超时，请重新登录！");
			return ResponseEntity.ok(map);
		}
		try {
			adminService.updatePassword(admin.getUserCode(), origpassword, newPassword);
			request.getSession().removeAttribute("admin");
			map.put("success", true);
			map.put("msg", "修改成功，请重新登录！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getStudentList")
	public ResponseEntity<?> getStudentList(StudentInfo studentInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = adminService.getStudentList(studentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getEmployeList")
	public ResponseEntity<?> getEmployeList(EmployeInfo employeInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = adminService.getEmployeList(employeInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getCourseList")
	public ResponseEntity<?> getCourseList(CourseInfo courseInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = adminService.getCourseList(courseInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateStudent")
	public ResponseEntity<?> updateStudent(@RequestBody Student student){
		Map<String, Object> map = new HashMap<>();
		try {
			adminService.updateStudent(student);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateEmploye")
	public ResponseEntity<?> updateEmploye(@RequestBody Employe employe){
		Map<String, Object> map = new HashMap<>();
		try {
			adminService.updateEmploye(employe);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateGrade")
	public ResponseEntity<?> updateGrade(@RequestBody Grade grade){
		Map<String, Object> map = new HashMap<>();
		try {
			adminService.updateGrade(grade);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateCourse")
	public ResponseEntity<?> updateCourse(@RequestBody Course course){
		Map<String, Object> map = new HashMap<>();
		try {
			adminService.updateCourse(course);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateTeaching")
	public ResponseEntity<?> updateTeaching(@RequestBody Teaching teaching){
		Map<String, Object> map = new HashMap<>();
		try {
			adminService.updateTeaching(teaching);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getGradeList")
	public ResponseEntity<?> getGradeList(GradeInfo gradeInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = adminService.getGradeList(gradeInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getTeachingList")
	public ResponseEntity<?> getTeachingList(HttpServletRequest request, TeachingInfo teachingInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = adminService.getTeachingList(teachingInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
}

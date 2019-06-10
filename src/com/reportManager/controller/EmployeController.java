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
import com.reportManager.pojo.Assignment;
import com.reportManager.pojo.AssignmentDetail;
import com.reportManager.pojo.Employe;
import com.reportManager.pojo.Labreport;
import com.reportManager.pojo.LabreportDetail;
import com.reportManager.pojo.Score;
import com.reportManager.pojo.Student;
import com.reportManager.pojo.info.AssignmentDetailInfo;
import com.reportManager.pojo.info.AssignmentInfo;
import com.reportManager.pojo.info.LabreportDetailInfo;
import com.reportManager.pojo.info.LabreportInfo;
import com.reportManager.pojo.info.TeachingInfo;
import com.reportManager.service.IAdminService;
import com.reportManager.service.IEmployeService;
import com.reportManager.utils.PageHelper;

@Controller
@RequestMapping("/employe")
public class EmployeController {

	@Resource
	private IEmployeService employeService;
	
	@Resource
	private IAdminService adminService;
	
	/**
	 * 访问员登录系统
	 */
	@RequestMapping
	public String employe(HttpServletRequest request, String type, String pageCode){
		Employe employe = (Employe)request.getSession().getAttribute("employe");
		if(employe == null){
			return "employe/login";
		}else if(StringUtils.isNotBlank(type) && StringUtils.isNotBlank(pageCode)){
			return type + "/" + pageCode;
		}else {
			return "employe/course";
		}
	}
	/**
	 * 跳转员工教师主页
	 */
	@RequestMapping("/login")
	public ResponseEntity<?> login(HttpServletRequest request,String userCode, String password){
		Map<String, Object> map = new HashMap<>();
		try {
			Employe employe = employeService.login(userCode, password);
			request.getSession().setAttribute("employe", employe);
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
		request.getSession().removeAttribute("employe");
		return type + "/login";
	}
	
	@PostMapping("/updatePassword")
	public ResponseEntity<?> updatePassword(HttpServletRequest request,String origpassword, String newPassword){
		Map<String, Object> map = new HashMap<>();
		Employe employe = (Employe)request.getSession().getAttribute("employe");
		if(employe == null){
			map.put("success", false);
			map.put("msg", "登录超时，请重新登录！");
		}
		try {
			employeService.updatePassword(employe.getWorkNumber(), origpassword, newPassword);
			request.getSession().removeAttribute("employe");
			map.put("success", true);
			map.put("msg", "修改成功，请重新登录！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getAssignmentList")
	public ResponseEntity<?> getAssignmentList(AssignmentInfo assignmentInfo, HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = employeService.getAssignmentList(assignmentInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getAssignmentDetailList")
	public ResponseEntity<?> getAssignmentDetailList(AssignmentDetailInfo assignmentDetailInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = employeService.getAssignmentDetailList(assignmentDetailInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateAssignment")
	public ResponseEntity<?> updateAssignment(@RequestBody Assignment Assignment){
		Map<String, Object> map = new HashMap<>();
		try {
			employeService.updateAssignment(Assignment);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateScore")
	public ResponseEntity<?> updateScore(@RequestBody AssignmentDetail assignmentDetail){
		Map<String, Object> map = new HashMap<>();
		try {
			employeService.updateScore(assignmentDetail);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateLabreportScore")
	public ResponseEntity<?> updateLabreportScore(@RequestBody LabreportDetail labreportDetail){
		Map<String, Object> map = new HashMap<>();
		try {
			employeService.updateLabreportScore(labreportDetail);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getLabreportList")
	public ResponseEntity<?> getLabreportList(LabreportInfo labreportInfo,HttpServletRequest request){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = employeService.getLabreportList(labreportInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getLabreportDetailList")
	public ResponseEntity<?> getLabreportDetailList(LabreportDetailInfo labreportDetailInfo){
		Map<String,Object> map = new HashMap<>();
		PageHelper info = employeService.getLabreportDetailList(labreportDetailInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateLabreport")
	public ResponseEntity<?> updateLabreport(@RequestBody Labreport labreport){
		Map<String, Object> map = new HashMap<>();
		try {
			employeService.updateLabreport(labreport);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getTeachingList")
	public ResponseEntity<?> getTeachingList(HttpServletRequest request, TeachingInfo teachingInfo){
		Employe employe = (Employe)request.getSession().getAttribute("employe");
		if(employe != null){
			teachingInfo.setEmploye(employe);
		}
		Map<String,Object> map = new HashMap<>();
		PageHelper info = adminService.getTeachingList(teachingInfo);
		map.put("data", info.getList());
		map.put("count", info.getTotal());
		map.put("code", 0);
		return ResponseEntity.ok(map);
	}
	
	@GetMapping("/getEmployeGrade")
	public ResponseEntity<?> getEmployeGrade(HttpServletRequest request){
		Map<String, Object> success = new HashMap<>();
		Employe employe = (Employe)request.getSession().getAttribute("employe");
		List<Map<String, Object>> employeGradeList = employeService.getEmployeGrade(employe.getEmployeId());
		success.put("success", true);
		success.put("data", employeGradeList);
		return ResponseEntity.ok(success);
	}
	
	@GetMapping("/getEmployeCourse")
	public ResponseEntity<?> getEmployeCourse(HttpServletRequest request, String gradeId){
		Map<String, Object> success = new HashMap<>();
		List<Map<String, Object>> employeGradeList = employeService.getEmployeCourse(gradeId);
		success.put("success", true);
		success.put("data", employeGradeList);
		return ResponseEntity.ok(success);
	}
	
	@PostMapping("/updateScoreTwo")
	public ResponseEntity<?> updateScoreTwo(@RequestBody Score score){
		Map<String, Object> map = new HashMap<>();
		try {
			employeService.updateScoreTwo(score);
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/updateScoreList")
	public ResponseEntity<?> updateScoreList(@RequestBody Score score){
		Map<String, Object> map = new HashMap<>();
		try {
			for (String studentId : score.getStudentIds()) {
				score.setStudentId(studentId);
				employeService.updateScoreTwo(score);
			}
			map.put("success", true);
			map.put("msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", "操作失败，" + e.getMessage());
		}
		return ResponseEntity.ok(map);
	}
	
}

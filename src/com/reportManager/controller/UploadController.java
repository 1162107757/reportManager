package com.reportManager.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/upload")
public class UploadController {

	// �����ļ��ϴ�
	@RequestMapping(value = "/uploadfile")
	public ResponseEntity<Map<String, Object>> uploadPicture(MultipartFile file,HttpServletRequest request) throws Exception{
		
		// ��Żص�������ͼƬ����
		Map<String, Object> src = new HashMap<>();
		// ��ȡ�ϴ����ļ���
		String fileName = file.getOriginalFilename();
		// ��ȡ��ǰ�ļ���չ��
		String extName = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + extName;
		// 
		// File newFile=new File("E:/images/" + newFileName);	// windows�ϴ�·��
		File newFile=new File(System.getProperty("catalina.home") + "/webapps/file/" + newFileName);	// linux�ϴ�·��
		file.transferTo(newFile);
		try {
			// ����·����ǰ̨
			src.put("src", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/file/" + newFileName);
			Map<String, Object> map = new HashMap<>();
			map.put("code", 0);
			map.put("msg", "�ϴ��ɹ�");
			map.put("data", src);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> map = new HashMap<>();
			map.put("code", 1);
			map.put("msg", "�ϴ�ʧ��");
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}

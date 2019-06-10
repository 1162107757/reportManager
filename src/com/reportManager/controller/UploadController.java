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

	// 单个文件上传
	@RequestMapping(value = "/uploadfile")
	public ResponseEntity<Map<String, Object>> uploadPicture(MultipartFile file,HttpServletRequest request) throws Exception{
		
		// 存放回调函数的图片链接
		Map<String, Object> src = new HashMap<>();
		// 获取上传的文件名
		String fileName = file.getOriginalFilename();
		// 获取当前文件扩展名
		String extName = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + extName;
		// 
		// File newFile=new File("E:/images/" + newFileName);	// windows上传路径
		File newFile=new File(System.getProperty("catalina.home") + "/webapps/file/" + newFileName);	// linux上传路径
		file.transferTo(newFile);
		try {
			// 返回路径到前台
			src.put("src", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/file/" + newFileName);
			Map<String, Object> map = new HashMap<>();
			map.put("code", 0);
			map.put("msg", "上传成功");
			map.put("data", src);
			return ResponseEntity.ok(map);
		} catch (Exception e) {
			e.printStackTrace();
			Map<String, Object> map = new HashMap<>();
			map.put("code", 1);
			map.put("msg", "上传失败");
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}

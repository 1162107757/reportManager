<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
$(function(){
	$.ajax({
		type : 'POST',
		dataType : 'json',
		url : './getAdminInfo',
		contentType : 'application/json',
		success : function(result){
			if(result != null){
				$("#userCode").text(result.adminCode);
			}
		}
	});
});

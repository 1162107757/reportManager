<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
$(".sidebar-scroll a").click(function(){
	window.location.href = "<%=basePath%>" + $(this).attr("type") + "?type=" + $(this).attr("type") +"&pageCode=" + $(this).attr("id");
});

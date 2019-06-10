<%@ page language="java" pageEncoding="UTF-8"%>

<!-- 权限标签 -->
<!-- C标签 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 环境变量 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${contextPath }/"></c:set>
<c:set var="basePathUrl" value="${basePath}v1/"></c:set>
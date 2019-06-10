<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录系统</title>
<script type="text/javascript" src="<%=basePath%>static/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/layui/lay/modules/layer.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/zui.css"
	media="all">
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/css/login.css"
	media="all">
<link href="<%=basePath%>static/css/animate.min.css" rel="stylesheet">
<link href="<%=basePath%>static/css/font-awesome.min.css" rel="stylesheet">
<link href="<%=basePath%>static/layui/css/layui.css" rel="stylesheet">
<link href="<%=basePath%>static/layui/css/modules/layer/default/layer.css" rel="stylesheet">
<link rel="stylesheet" href="../static/css/font-awesome.min.css">
<style>
body {
	background-image: url(<%=basePath%>static/images/4.jpg);
}
</style>
</head>
<body>
	<div id="main-box"></div>
	<div id="main-content">
		<div class="login-body  animated fadeInLeft">
			<div class="login-main pr">
				<form class="login-form layui-form" onsubmit="return false">
					<h3>教师登录</h3>
					<h5 style="padding-bottom: 10px">System Management Center</h5>
					<!-- 账号登陆 -->
					<div class="input-group user-name">
						<span class="input-group-addon"><i class="fa fa-user"></i></span> <input
							type="text" name="userCode" class="form-control layui-input"
							placeholder="用户名/手机号">
					</div>
					<div class="input-group password">
						<span class="input-group-addon"><i class="fa fa-lock"></i></span> <input
							type="password" name="password" class="form-control layui-input"
							placeholder="密码">
					</div>
					<!-- <div class="use-qrcode-a"><a class="use-ding" href="javascript:void(0)"><img src="images/ding.png" width="17" height="17" style="margin-top:-2px"> 钉钉账号登陆</a> </div> -->
					<div class="login_btn_panel">
						<a lay-submit lay-filter="login" class=" btn btn-primary btn-block btn-lg"
							type="submit">登录</a>
						<div class="check-tips"></div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
layui.use('form', function(){
	var form = layui.form;
	form.on('submit(login)', function(data){
		$.ajax({
			type:'POST',
			url:'<%=basePath%>employe/login',
			dataType:'json',
			data:{'userCode':data.field.userCode,'password':data.field.password},
			success:function(result){
				if(!result.success){
					layer.msg(result.msg);
				}else{
					window.location.href="<%=basePath%>employe";
				}
			},
			error : function(errorInfo){
				layer.msg('系统错误！');
			}
		});
		return false;
	});
});
</script>
</html>
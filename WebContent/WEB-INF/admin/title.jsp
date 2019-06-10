<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
<div class="container-fluid">
	<!-- <div class="navbar-btn">
		<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
	</div> -->
	<div id="navbar-menu">
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="<%=basePath %>static/assets/img/user.png" class="img-circle" alt="Avatar"> <span id="userCode"></span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
				<ul class="dropdown-menu">
					<li id="updatePassword" type="admin"><a href="#"><i class="fa fa-edit"></i> <span>修改密码</span></a></li>
					<li id="loginout" type="admin"><a href="#"><i class="lnr lnr-exit"></i> <span>退出</span></a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>
<script>
	$("#updatePassword").click(function(){
		layer.open({
			type : 2,				
			title : '修改密码',
			btnAlign: 'c',
		  	content: '<%=basePath%>common/update_password.jsp?type=' + $(this).attr("type"),
		  	btn : ['确定','取消'],
		  	area : ['400px','240px'],
		  	yes : function(index, layero){
		  		var body = layer.getChildFrame('body',index);//建立父子联系
	            var iframeWin = window[layero.find('iframe')[0]['name']];
	            iframeWin.updatePassword();
		  	}
		});	
	});
	
	$("#loginout").click(function(){
		console.log(666666666);
		var type = $(this).attr("type");
		layer.confirm('确定退出?', {icon: 3, title:'提示'}, function(index){
			window.location.href="<%=basePath %>" + type + "/loginout?type=" + type;
		});
	});
</script>
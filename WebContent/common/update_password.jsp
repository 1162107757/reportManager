<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="<%=basePath %>static/layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath %>static/layui/css/modules/layer/default/layer.css">
<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
<script src="<%=basePath %>static/layui/layui.all.js"></script>
<div>
	<div>
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">原密码</label>
		      <div class="layui-input-inline">
		        <input type="text" style="width: 220px;margin-top: 20px;" name="origpassword" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">新密码</label>
		      <div class="layui-input-inline">
		        <input type="text" style="width: 220px;margin-top: 20px;" name="newPassword" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		</div>
	</div>
</div>
<script>
function updatePassword(){
	var classType = '<%=request.getParameter("type")%>';
	$.ajax({
		type:'POST',
		url:'<%=basePath%>' + classType + '/updatePassword',
		dataType:'json',
		async: false,
		data:{'origpassword':$("input[name='origpassword']").val(),'newPassword':$("input[name='newPassword']").val()},
		success:function(result){
			layer.msg(result.msg);
			setTimeout(function(){
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index);
			},2000);
		},
		error : function(errorInfo){
			layer.msg('系统错误！');
		}
	});
}
</script>
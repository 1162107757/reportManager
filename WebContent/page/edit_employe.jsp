<%@ include file="/common/taglib.jsp" %>
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
<style>
	.grade dl{
		height: 160px;
	}
</style>
<div>
	<div>
		<form onsubmit="return false" class="layui-form" id="employe">
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">教师名称</label>
			      <div class="layui-input-inline" style="width: 220px;margin-top: 20px;">
			        <input type="text" style="width: 220px;margin-top: 20px;" name="employeName" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">教师工号</label>
			      <div class="layui-input-inline" style="width: 220px;">
			        <input type="text" style="width: 220px;margin-top: 20px;" name="workNumber" autocomplete="off" class="layui-input">
			        <input type="hidden" style="width: 220px;margin-top: 20px;" name="employeId" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div style="display: none;">
				<button type="button" class="layui-btn" lay-submit lay-filter="updateEmploye" id="updateEmploye">提交</button>
			</div>
		</form>
	</div>
</div>

<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
<script src="<%=basePath %>static/layui/layui.all.js"></script>

<script>
var form;
layui.use(['table','form'], function(){
	form = layui.form;
	// 加载课程
	$.ajax({
		url:'<%=basePath%>admin/getCourseList?page=1&limit=99999',
		type:'get',
		dataType:'json',
		async:false,
		success:function(result){
			for (var i = 0; i < result.data.length; i++) {
				var course = result.data[i];
				$("#gradeId").append('<option value="' + course.gradeId + '">' + course.gradeName + '</option>');
			}
		}
	});
	form.render();
	
	form.on('submit(updateEmploye)', function(data){
		console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		$.ajax({
			url:'<%=basePath%>admin/updateEmploye',
			type:'post',
			dataType:'json',
			data:JSON.stringify(data.field),
			contentType:'application/json',
			success:function(result){
				var index = parent.layer.getFrameIndex(window.name);
				layer.msg(result.msg);
				setTimeout(function(){
					parent.layer.close(index);
					parent.loadTable();
				},2000);
			}
		});s
		return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	
});

function loadEmploye(employe){
	$("input[name='employeName']").val(employe.employeName);
	$("input[name='workNumber']").val(employe.workNumber);
	$("input[name='employeId']").val(employe.employeId);
	form.render();
}

function updateEmploye(){
	$("#updateEmploye").trigger("click");
}
</script>
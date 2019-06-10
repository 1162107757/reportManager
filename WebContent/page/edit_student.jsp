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
		<form onsubmit="return false" class="layui-form" id="student">
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">班级</label>
			      <div class="layui-input-inline grade" style="width: 220px;margin-top: 20px;">
				      <select name="gradeId" id="gradeId">
				      
				      </select>
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">性别</label>
			      <div class="layui-input-inline" style="width: 220px;">
				      <select name="sex">
				        <option value="1">男</option>
				        <option value="0">女</option>
				      </select>
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">名字</label>
			      <div class="layui-input-inline">
			        <input type="hidden" style="width: 220px;margin-top: 20px;" name="studentId" autocomplete="off" class="layui-input">
			        <input type="text" style="width: 220px;margin-top: 20px;" name="name" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">学号</label>
			      <div class="layui-input-inline">
			        <input type="text" style="width: 220px;margin-top: 20px;" name="studentNumber" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div style="display: none;">
				<button type="button" class="layui-btn" lay-submit lay-filter="updateStudent" id="updateStudent">提交</button>
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
		url:'<%=basePath%>admin/getGradeList?page=1&limit=99999',
		type:'get',
		dataType:'json',
		async:false,
		success:function(result){
			for (var i = 0; i < result.data.length; i++) {
				var grade = result.data[i];
				$("#gradeId").append('<option value="' + grade.gradeId + '">' + grade.gradeName + '</option>');
			}
		}
	});
	form.render();
	
	form.on('submit(updateStudent)', function(data){
		console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		$.ajax({
			url:'<%=basePath%>admin/updateStudent',
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

function loadStudent(student){
	$("select[name='gradeId']").find("option[value='" + student.gradeId + "']").prop("selected",true);
	$("select[name='sex']").find("option[value='" + student.sex + "']").prop("selected",true);
	$("input[name='name']").val(student.name);
	$("input[name='studentNumber']").val(student.studentNumber);
	$("input[name='studentId']").val(student.studentId);
	form.render();
}

function updateStudent(){
	$("#updateStudent").trigger("click");
}
</script>
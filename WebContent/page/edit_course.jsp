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
			      <label class="layui-form-label">课程名称</label>
			      <div class="layui-input-inline">
			        <input type="hidden" style="width: 220px;margin-top: 20px;" name="courseId" autocomplete="off" class="layui-input">
			        <input type="text" style="width: 220px;margin-top: 20px;" name="courseName" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div style="display: none;">
				<button type="button" class="layui-btn" lay-submit lay-filter="updateCourse" id="updateCourse">提交</button>
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
	
	form.on('submit(updateCourse)', function(data){
		console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		$.ajax({
			url:'<%=basePath%>admin/updateCourse',
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

function loadCourse(course){
	console.log(course)
	$("input[name='courseName']").val(course.courseName);
	$("input[name='courseId']").val(course.courseId);
	form.render();
}

function updateCourse(){
	$("#updateCourse").trigger("click");
}
</script>
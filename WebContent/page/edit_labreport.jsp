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
<script src="<%=basePath %>common/datecommon.jsp"></script>
<style>
	.grade dl{
		height: 160px;
	}
	.layui-laydate{
		left: 65px;
    	top: 15px;
	}
</style>
<div>
	<div>
		<form onsubmit="return false" class="layui-form" id="teaching">
			<div class="layui-form-item">
			    <div class="layui-inline" style="margin-top: 20px;">
			      <label class="layui-form-label">报告名称</label>
			      <div class="layui-input-inline grade" >
			      	<input type="text" style="width: 400px" name="labreportName" id="labreportName" autocomplete="off" class="layui-input">
			      	<input type="hidden" style="width: 400px" name="labreportId" id="labreportId" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">班级名称</label>
			      <div class="layui-input-inline grade" style="width: 400px">
				      <select name="gradeId" id="gradeId" >
				      
				      </select>
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">课程名称</label>
			      <div class="layui-input-inline grade" style="width: 400px">
				      <select name="courseId" id="courseId" >
				      
				      </select>
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">作业附件</label>
			      <div class="layui-input-inline grade" style="width: 400px">
			      	<input type="text" style="width: 297px;display: inline-block;" name="fileUrl" readonly="readonly" id="fileUrl" autocomplete="off" class="layui-input">
			      	<button type="button" style="margin-left: 30px;" class="layui-btn layui-btn-sm" id="selectFile">选择文件</button>
			      </div>
			    </div>
			</div>
			<div style="display: none;">
				<button type="button" class="layui-btn" lay-submit lay-filter="updateLabreport" id="updateLabreport">提交</button>
			</div>
		</form>
	</div>
</div>

<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
<script src="<%=basePath %>static/layui/layui.all.js"></script>

<script>

layui.use('upload', function(){
	var upload = layui.upload;
	  //执行实例
	var uploadInst = upload.render({
		elem: '#selectFile' //绑定元素
	    ,url: '<%=basePath%>/upload/uploadfile' //上传接口
	    ,accept: 'file'
	    ,done: function(res){
	      //上传完毕回调
			$("#fileUrl").val(res.data.src);
	    }
	    ,error: function(){
	      //请求异常回调
	    }
	});
});

var form;
layui.use(['table','form', 'laydate'], function(){
	form = layui.form;
	var laydate = layui.laydate;
	// 加载教师
	$.ajax({
		url:'<%=basePath%>admin/getEmployeList?page=1&limit=99999',
		type:'get',
		dataType:'json',
		async:false,
		success:function(result){
			for (var i = 0; i < result.data.length; i++) {
				var employe = result.data[i];
				$("#employeId").append('<option value="' + employe.employeId + '">' + employe.employeName + '</option>');
			}
		}
	});
	// 加载班级
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
	// 加载课程
	$.ajax({
		url:'<%=basePath%>admin/getCourseList?page=1&limit=99999',
		type:'get',
		dataType:'json',
		async:false,
		success:function(result){
			for (var i = 0; i < result.data.length; i++) {
				var course = result.data[i];
				$("#courseId").append('<option value="' + course.courseId + '">' + course.courseName + '</option>');
			}
		}
	});
	
	form.render();
	
	form.on('submit(updateLabreport)', function(data){
		console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		$.ajax({
			url:'<%=basePath%>employe/updateLabreport',
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
		});
		return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	
});

function loadLabreport(labreport){
	console.log(labreport);
	$("select[name='gradeId']").find("option[value='" + labreport.gradeId + "']").prop("selected",true);
	$("select[name='courseId']").find("option[value='" + labreport.courseId + "']").prop("selected",true);
	$("input[name='labreportName']").val(labreport.labreportName);
	$("input[name='labreportId']").val(labreport.labreportId);
	$("input[name='fileUrl']").val(labreport.fileUrl);
	form.render();
}

function updateLabreport(){
	$("#updateLabreport").trigger("click");
}
</script>
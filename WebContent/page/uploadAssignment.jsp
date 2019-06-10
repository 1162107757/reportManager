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

<div>
	<div style="margin-top: 40px;">
		<form class="layui-form" onsubmit="return false">
			<div class="layui-form-item">
			    <div class="layui-inline">
			      <label class="layui-form-label">作业附件</label>
			      <div class="layui-input-inline grade" style="width: 400px">
			      	<input type="text" style="width: 297px;display: inline-block;" name="fileUrl" readonly="readonly" id="fileUrl" autocomplete="off" class="layui-input">
			      	<input type="hidden" style="width: 297px;display: inline-block;" name="assignmentId" readonly="readonly" id="fileUrl" autocomplete="off" class="layui-input">
			      	<button type="button" style="margin-left: 30px;" class="layui-btn layui-btn-sm" id="selectFile">选择文件</button>
			      </div>
			    </div>
			</div>
			<div style="display: none;">
				<button type="button" class="layui-btn" lay-submit lay-filter="updateAssignment" id="updateAssignment">提交</button>
			</div>
		</form>
	</div>
</div>

<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
<script src="<%=basePath %>static/layui/layui.all.js"></script>

<script>
var form;
layui.use(['table','form', 'laydate'], function(){
	form = layui.form;
	form.on('submit(updateAssignment)', function(data){
		console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
		$.ajax({
			url:'<%=basePath%>student/updateAssignment',
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

function loadAssignment(assignment){
	$("input[name='assignmentId']").val(assignment.assignmentId);
	form.render();
}

function updateAssignment(){
	$("#updateAssignment").trigger("click");
}
</script>
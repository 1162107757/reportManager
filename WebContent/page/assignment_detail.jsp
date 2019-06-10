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

<div>
	<div>
		<table id="assignments" lay-filter="assignments"></table>
	</div>
</div>

<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
<script src="<%=basePath %>static/layui/layui.all.js"></script>
<script type="text/html" id="opertion">
		<button style="width: 70px;" id="deleteProduct" class="layui-btn layui-btn-xs" lay-event="downloadAssignment"><i class="icons icon_revise"></i>下载作业</button>
		<button style="width: 70px;" id="deleteProduct" class="layui-btn layui-btn-xs" lay-event="score"><i class="icons icon_revise"></i>评分</button>
	</script>
<script>
function loadTable(ad){
	console.log(ad)
	layui.use(['laydate','form','table'], function(){
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		form.render();
		//第一个实例
		table.render({
			elem: '#assignments'
		    ,height: 490
		    ,url: '<%=basePath%>employe/getAssignmentDetailList?assignmentId=' + ad.assignmentId //数据接口
		    ,page: true //开启分页
		    ,cols: [[ //表头
		    	{type: 'numbers', title: '序号'}
				,{field: 'assignmentName', title: '作业名称'} 
				,{field: 'name', title: '学生名称'} 
				,{field: 'score', title: '分数'} 
				,{field: 'opertion',title: '操作', toolbar:'#opertion', align:'center'}
			]]
		});
	});
}

layui.use('table', function(){
	var table = layui.table;
	table.on('tool(assignments)', function(obj){
		if(obj.event === 'downloadAssignment'){
			window.location.href = obj.data.fileUrl;
		}else if(obj.event === 'score'){
			layer.open({
				title: '评分'
				,content: '<input autocomplete="off" name="score" class="layui-input"></input>'
				,yes: function(index, layero){
					var score = $("input[name='score']").val();
					var studentId = obj.data.studentId;
					var assignmentDetailId = obj.data.assignmentDetailId;
					var data = {"score":score,"studentId":studentId,"assignmentDetailId":assignmentDetailId};
					$.ajax({
						url:'<%=basePath%>/employe/updateScore',
						dataType:'json',
						type:'post',
						contentType:'application/json',
						data:JSON.stringify(data),
						success:function(result){
							layer.msg(result.msg);
							if(result.success){
								setTimeout(function(){
									var ad = new Object();
									eval('ad.assignmentId="' + obj.data.assignmentId + '"');
									loadTable(ad);
								},2000);
							}
						}
					})
				}
			});     
				  
		}
	})
})
</script>
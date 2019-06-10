<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
	<title>管理员后台</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="<%=basePath %>static/assets/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=basePath %>static/assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=basePath %>static/assets/vendor/linearicons/style.css">
	<link rel="stylesheet" href="<%=basePath %>static/assets/vendor/chartist/css/chartist-custom.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="<%=basePath %>static/assets/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="<%=basePath %>static/assets/css/demo.css">
	<link rel="stylesheet" href="<%=basePath %>static/css/font-awesome.min.css">
	<!-- layui -->
	<link rel="stylesheet" href="<%=basePath %>static/layui/css/layui.css">
	<link rel="stylesheet" href="<%=basePath %>static/layui/css/modules/layer/default/layer.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="<%=basePath %>static/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="<%=basePath %>static/assets/img/favicon.png">
</head>

<body>
	<!-- WRAPPER -->
	<div id="wrapper">
		<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
				<a href="index.html" style="font-size: 17px;">教师后台</a>
			</div>
			<jsp:include page="../student/title.jsp"></jsp:include>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li><a href="#" type="employe" class="" id="course"><i class="fa fa-file-text-o"></i> <span>查看课程</span></a></li>
						<li><a href="#" type="employe" class="" id="assignment"><i class="fa fa-file-text-o"></i> <span>作业列表</span></a></li>
						<li><a href="#" type="employe" class="" id="labreport"><i class="fa fa-file-text-o"></i> <span>实验报告</span></a></li>
						<li><a href="#" type="employe" class="" id="rollcall"><i class="fa fa-file-text-o"></i> <span>考勤系统</span></a></li>
						<li><a href="#" type="employe" class="active" id="courseAddScore"><i class="fa fa-file-text-o"></i> <span>课程出勤/表现分数</span></a></li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<div>
						<div>
							<form class="layui-form" onsubmit="return false" id="grade">
								<div class="layui-form-item">
								    <label class="layui-form-label" style="width: 110px;">选择班级</label>
								    <div class="layui-input-inline" style="width: 300px;">
								      <select name="gradeList" id="gradeList" lay-filter="gradeList">
								      </select>
								    </div>
								    <label class="layui-form-label" style="width: 110px;">选择课程</label>
								    <div class="layui-input-inline" style="width: 300px;">
								      <select name="courseList" id="courseList" lay-filter="courseList">
								        <option value="">请选择课程</option>
								      </select>
								    </div>
								</div>
							</form>
						</div>
					</div>
					<div style="margin-left: 25%;margin-top: 5%;" id="randomStudent">
					</div>
					<div>
						<table id="students" lay-filter="students"></table>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			<div class="container-fluid">
				
			</div>
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="<%=basePath %>static/assets/vendor/jquery/jquery.min.js"></script>
	<script src="<%=basePath %>static/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=basePath %>static/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="<%=basePath %>static/assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="<%=basePath %>static/assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="<%=basePath %>static/assets/scripts/klorofil-common.js"></script>
	<!-- layui -->
	<script src="<%=basePath %>static/layui/layui.all.js"></script>
	<script src="<%=basePath %>login.jsp"></script>
	<script src="<%=basePath %>jump.jsp"></script>
	<script src="<%=basePath %>common/datecommon.jsp"></script>
	<script type="text/html" id="opertion">
		<button style="width: 70px;" id="courseAddScore" class="layui-btn layui-btn-xs" lay-event="courseAddScore"><i class="icons icon_revise"></i>加分</button>
	</script>
	<script>
	
	layui.use('table', function(){
		var table = layui.table;
		table.on('tool(students)', function(obj){
			if(obj.event === 'courseAddScore'){
				var courseId = $("select[name='courseList']").find("option:selected").val();
				layer.open({
					type : 1,				
					title : '加分',
					btnAlign: 'c',
				  	content: '<div align="center" style="margin-top: 37px;">确定加分？</div>',
				  	btn : ['确定','取消'],
				  	closeBtn: 0,
				  	area : ['200px','180px'],
				  	yes : function(index, layero){
				  		var courseId = $("select[name='courseList']").find("option:selected").val();
				  		// 更新考勤状态
				  		$.ajax({
				  			type:'post',
				  			dataType:'json',
				  			data:JSON.stringify({"studentId":obj.data.studentId,"courseId":courseId,"reasonContent":2}),
				  			contentType:'application/json',
				  			url:'<%=basePath%>employe/updateScoreTwo',
				  			success:function (result){
				  				layer.msg(result.msg)
				  				tableReload.reload();
				  			}
				  		});
				  		
			           	layer.close(index);
				  	}
				});
			}
		})
	})
	
	var tableReload = null;
	
	layui.use('form', function(){
		var form = layui.form;
		$.ajax({
			url:'<%=basePath%>employe/getEmployeGrade',
			dataType:'json',
			type:'get',
			success:function(result){
				$("select[name='gradeList']").empty();
				$("select[name='gradeList']").append('<option value="">请选择班级</option>');
				for (var i = 0; i < result.data.length; i++) {
					var grade = result.data[i];
					$("select[name='gradeList']").append('<option value="' + grade.gradeId +'">' + grade.gradeName + '</option>');
				}
				form.render();
			}
		})
		
		// 监听课程
		form.on('select(courseList)', function(data){
			var courseId = data.value;
			var gradeId = $("select[name='gradeList']").find("option:selected").val();
			layui.use(['laydate','form','table'], function(){
				var laydate = layui.laydate;
				var form = layui.form;
				var table = layui.table;
				form.render();
				//第一个实例
				tableReload = table.render({
					elem: '#students'
				    ,height: 490
				    ,url: '<%=basePath%>admin/getStudentList?gradeId=' + gradeId + "&courseId=" + courseId //数据接口
				    ,page: true //开启分页
				    ,cols: [[ //表头
				    	{type: 'numbers', title: '序号'}
						,{field: 'gradeName', title: '班级名称'} 
						,{field: 'name', title: '学生姓名'} 
						,{field: 'studentNumber', title: '学号'} 
						,{field: 'sex', title: '性别',templet:function(d){
							if(d.sex == 1){
								return "男"
							}else{
								return "女";
							}
						}} 
						,{field: 'addScore', title: '平时表现分'} 
						,{field: 'subScore', title: '考勤分'} 
						,{field: 'opertion',title: '操作', toolbar:'#opertion', align:'center'}
					]]
				});
			});
			
		})
		
		// 监听班级选择
		form.on('select(gradeList)', function(data){
			// 班级的ID
			var gradeId = data.value;
			if(gradeId != ''){
				// 加载课程
				$.ajax({
					url:'<%=basePath%>employe/getEmployeCourse?page=1&limit=99999&gradeId=' + gradeId,
					type:'get',
					dataType:'json',
					success:function(result){
						$("select[name='courseList']").empty();
						$("select[name='courseList']").append('<option value="">请选择课程</option>');
						for (var i = 0; i < result.data.length; i++) {
							var course = result.data[i];
							$("select[name='courseList']").append('<option value="' + course.courseId +'">' + course.courseName + '</option>');
						}
						form.render();
					}
				})
			}
		});
	});
	
	$(function() {
		var data, options;

		// headline charts
		data = {
			labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
			series: [
				[23, 29, 24, 40, 25, 24, 35],
				[14, 25, 18, 34, 29, 38, 44],
			]
		};

		options = {
			height: 300,
			showArea: true,
			showLine: false,
			showPoint: false,
			fullWidth: true,
			axisX: {
				showGrid: false
			},
			lineSmooth: false,
		};

		new Chartist.Line('#headline-chart', data, options);


		// visits trend charts
		data = {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
			series: [{
				name: 'series-real',
				data: [200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
			}, {
				name: 'series-projection',
				data: [240, 350, 360, 380, 400, 450, 480, 523, 555, 600, 700, 800],
			}]
		};

		options = {
			fullWidth: true,
			lineSmooth: false,
			height: "270px",
			low: 0,
			high: 'auto',
			series: {
				'series-projection': {
					showArea: true,
					showPoint: false,
					showLine: false
				},
			},
			axisX: {
				showGrid: false,

			},
			axisY: {
				showGrid: false,
				onlyInteger: true,
				offset: 0,
			},
			chartPadding: {
				left: 20,
				right: 20
			}
		};

		new Chartist.Line('#visits-trends-chart', data, options);


		// visits chart
		data = {
			labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
			series: [
				[6384, 6342, 5437, 2764, 3958, 5068, 7654]
			]
		};

		options = {
			height: 300,
			axisX: {
				showGrid: false
			},
		};

		new Chartist.Bar('#visits-chart', data, options);

		var updateInterval = 3000; // in milliseconds

		function getRandomInt(min, max) {
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}

	});
	</script>
</body>

</html>

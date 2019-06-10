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
				<a href="index.html" style="font-size: 17px;">学生后台</a>
			</div>
			<jsp:include page="../student/title.jsp"></jsp:include>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li><a href="#" type="student" class="" id="labreport"><i class="fa fa-file-text-o"></i> <span>实验报告</span></a></li>
						<li><a href="#" type="student" class="" id="assignment"><i class="fa fa-file-text-o"></i> <span>作业列表</span></a></li>
						<li><a href="#" type="student" class="active" id="finalScore"><i class="fa fa-file-text-o"></i> <span>查看成绩</span></a></li>
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
						<div><h3>作业平均分</h3></div>
						<div style="display: inline-block;width: 100%;">
							<table id="assignmentAvgs" lay-filter="assignmentAvgs"></table>
						</div>
					</div>
					<div>
						<div><h3>报告平均分</h3></div>
						<div style="display: inline-block;width: 100%; ">
							<table id="labreportAvgs" lay-filter="labreportAvgs"></table>
						</div>
					</div>
					<div>
						<div><h3>课程出勤/表现分数</h3></div>
						<div style="display: inline-block;width: 100%; ">
							<table id="students" lay-filter="students"></table>
						</div>
					</div>
					<div>
						<div><h3>最终成绩</h3></div>
						<div style="display: inline-block;width: 100%; ">
							<table id="finalScoreList" lay-filter="finalScoreList"></table>
						</div>
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
	<script type="text/javascript">
		$(function(){
			loadTableAssignmentAvgs();
			loadTableLabreportAvgs();
			loadStudent();
			loadFinalScore();
		})
		
		function loadFinalScore(){
			layui.use(['laydate','form','table'], function(){
				var laydate = layui.laydate;
				var form = layui.form;
				var table = layui.table;
				form.render();
				//第一个实例
				table.render({
					elem: '#finalScoreList'
				    ,height: 300
				    ,url: '<%=basePath%>student/getFinalScoreByStudentId' //数据接口
				    ,page: true //开启分页
				    ,cols: [[ //表头
				    	{type: 'numbers', title: '序号'}
						,{field: 'courseName', title: '课程名称'} 
						,{field: 'allScore', title: '最终分'} 
					]]
				});
			});
		}
		function loadStudent(){
			layui.use(['laydate','form','table'], function(){
				var laydate = layui.laydate;
				var form = layui.form;
				var table = layui.table;
				form.render();
				//第一个实例
				table.render({
					elem: '#students'
				    ,height: 300
				    ,url: '<%=basePath%>student/getScoreByStudentId' //数据接口
				    ,page: true //开启分页
				    ,cols: [[ //表头
				    	{type: 'numbers', title: '序号'}
						,{field: 'courseName', title: '课程名称'} 
						,{field: 'addScore', title: '平时表现分'} 
						,{field: 'subScore', title: '考勤分'} 
					]]
				});
			});
		}
		
		function loadTableAssignmentAvgs(){
			layui.use(['laydate','form','table'], function(){
				var laydate = layui.laydate;
				var form = layui.form;
				var table = layui.table;
				form.render();
				//第一个实例
				table.render({
					elem: '#assignmentAvgs'
				    ,height: 300
				    ,url: '<%=basePath%>student/getAssignmentAveList' //数据接口
				    ,page: true //开启分页
				    ,cols: [[ //表头
				    	{type: 'numbers', title: '序号'}
						,{field: 'courseName', title: '课程名称'}
						,{field: 'avgScore', title: '学期平均分'} 
					]]
				});
			});
		}
		
		function loadTableLabreportAvgs(){
			layui.use(['laydate','form','table'], function(){
				var laydate = layui.laydate;
				var form = layui.form;
				var table = layui.table;
				form.render();
				//第一个实例
				table.render({
					elem: '#labreportAvgs'
				    ,height: 300
				    ,url: '<%=basePath%>student/getLabreportAveList' //数据接口
				    ,page: true //开启分页
				    ,cols: [[ //表头
				    	{type: 'numbers', title: '序号'}
						,{field: 'courseName', title: '课程名称'}
						,{field: 'avgScore', title: '学期平均分'} 
					]]
				});
			});
		}
	</script>
	<script>
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

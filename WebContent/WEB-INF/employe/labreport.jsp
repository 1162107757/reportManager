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
			<jsp:include page="../employe/title.jsp"></jsp:include>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li><a href="#" type="employe" class="" id="course"><i class="fa fa-file-text-o"></i> <span>查看课程</span></a></li>
						<li><a href="#" type="employe" class="" id="assignment"><i class="fa fa-file-text-o"></i> <span>作业列表</span></a></li>
						<li><a href="#" type="employe" class="active" id="labreport"><i class="fa fa-file-text-o"></i> <span>实验报告</span></a></li>
						<li><a href="#" type="employe" class="" id="rollcall"><i class="fa fa-file-text-o"></i> <span>考勤系统</span></a></li>
						<li><a href="#" type="employe" class="" id="courseAddScore"><i class="fa fa-file-text-o"></i> <span>课程出勤/表现分数</span></a></li>
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
						<button type="button" class="layui-btn" lay-submit lay-filter="addLabreports" id="addLabreports">新增</button>
					</div>
					<div>
						<table id="labreports" lay-filter="labreports"></table>
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
		<button style="width: 70px;" id="deleteProduct" class="layui-btn layui-btn-xs" lay-event="edit"><i class="icons icon_revise"></i>编辑</button>
		<button style="width: 70px;" id="deleteProduct" class="layui-btn layui-btn-xs" lay-event="labreportList"><i class="icons icon_revise"></i>提交列表</button>
	</script>
	<script type="text/javascript">
	
		
		$("#addLabreports").click(function(){
			layer.open({
				type : 2,				
				title : '新增',
				btnAlign: 'c',
			  	content: '<%=basePath%>page/edit_labreport.jsp',
			  	btn : ['确定','取消'],
			  	area : ['600px','460px'],
			  	yes : function(index, layero){
			  		var body = layer.getChildFrame('body',index);//建立父子联系
		            var iframeWin = window[layero.find('iframe')[0]['name']];
		           	iframeWin.updateLabreport();
			  	}
			});
		});
		
		layui.use('table', function(){
			var table = layui.table;
			table.on('tool(labreports)', function(obj){
				if(obj.event === 'edit'){
					layer.open({
						type : 2,				
						title : '编辑',
						btnAlign: 'c',
					  	content: '<%=basePath%>page/edit_labreport.jsp',
					  	btn : ['确定','取消'],
					  	area : ['600px','460px'],
					  	yes : function(index, layero){
					  		var body = layer.getChildFrame('body',index);//建立父子联系
				            var iframeWin = window[layero.find('iframe')[0]['name']];
				           	iframeWin.updateLabreport();
					  	},
					  	success:function(layero, index){
					  		var body = layer.getChildFrame('body',index);//建立父子联系
				            var iframeWin = window[layero.find('iframe')[0]['name']];
				           	iframeWin.loadLabreport(obj.data);
					  	}
					});
				}else if(obj.event === 'labreportList'){
					layer.open({
						type : 2,				
						title : '编辑',
						btnAlign: 'c',
					  	content: '<%=basePath%>page/labreport_detail.jsp',
					  	btn : ['确定','取消'],
					  	area : ['1000px','620px'],
					  	success:function(layero, index){
					  		var body = layer.getChildFrame('body',index);//建立父子联系
				            var iframeWin = window[layero.find('iframe')[0]['name']];
				           	iframeWin.loadTable(obj.data);
					  	}
					});
				}
			})
		})
		
		$(function(){
			loadTable();
		})
		
		function loadTable(){
			layui.use(['laydate','form','table'], function(){
				var laydate = layui.laydate;
				var form = layui.form;
				var table = layui.table;
				form.render();
				//第一个实例
				table.render({
					elem: '#labreports'
				    ,height: 490
				    ,url: '<%=basePath%>employe/getLabreportList' //数据接口
				    ,page: true //开启分页
				    ,cols: [[ //表头
				    	{type: 'numbers', title: '序号'}
						,{field: 'labreportName', title: '报告名称'} 
						,{field: 'gradeName', title: '班级名称'} 
						,{field: 'courseName', title: '课程名称'} 
						,{field: 'createTime', title: '上课时间',templet:function(d){
							return formatDate(d.createTime);
						}}
						,{field: 'opertion',title: '操作', toolbar:'#opertion', align:'center'}
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

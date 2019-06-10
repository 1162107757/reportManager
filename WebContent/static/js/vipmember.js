layui.use(['form', 'layedit', 'laydate'], function(){
	var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;
	//日期
	laydate.render({
		elem: '#regStartDate'
		,type: 'datetime'
	});
	laydate.render({
		elem: '#regEndDate'
		,type: 'datetime'
	});
	form.render();
	
	form.on('submit(search)', function(data){
		console.log(data.field);
		loadTable(data.field);
	});
	
});
$(function(){
	loadTable();
});
function loadTable(){
	
	var searchUser = $("#searchUser").serialize();
	
	layui.use('table', function(){
		var table = layui.table;
		tabContent = table.render({
			elem: "#userList"
			,url: './user/getAllUser?' + searchUser //数据接口
			,page: true //开启分页
			,limits:[10,20,50,100]
			,cols: [[ //表头
				{field: 'userCode', title: '用户名',width:150},
				{field: 'userName', title: '昵称',width:120},
				{field: 'sex', title: '性别',width:70,templet: function(d){
					if(d.sex){
						return "男";
					}else{
						return "女";
					}
			    }},
				{field: 'birthday', title: '生日',width:120},
				{field: 'provinceName', title: '省',width:80},
				{field: 'cityName', title: '市',width:80},
				{field: 'areaName', title: '区',width:80},
				{field: 'status', title: '状态',width:70,templet: function(d){
					if(d.status){
						return "启用";
					}else{
						return "停用";
					}
			    }},
				{field: 'email', title: '邮箱'},
				{field: 'operation', title: '操作',toolbar:"#operation"},
			]]
			,done :function(res,currPage,count){
				if(count != 0){
					if(res.data.length == 0){
						table.reload('userList', {
							page: {
								curr: currPage - 1 //重新从第 1 页开始
							}
						});
					}
				}
			}
		});
		
		table.on('tool(userList)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
			var data = obj.data; //获得当前行数据
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的DOM对象
			if(layEvent === 'edit'){ //查看
				layer.open({
					type : 2,				
					title : '添加会员',
					btnAlign: 'c',
				  	content: './admin/edit_vipmember.html',
				  	area : ['713px','700px'],
				  	btn : ['确定','取消'],
				  	yes : function(index, layero){
				  		var body = layer.getChildFrame('body',index);//建立父子联系
			            var iframeWin = window[layero.find('iframe')[0]['name']];
			           	iframeWin.clickAddUser();
				  	},
				  	success:function(layero,index){
				  		var body = layer.getChildFrame('body', index);
				  	    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
				  	    iframeWin.loadData(data);
				  	}
				});
			}else if(layEvent === 'del'){
				layer.confirm('确定删除？', function(index){
					$.ajax({
						type:'POST',
						url:'./user/delUser',
						dataType:'json',
						data:{"userId":data.userId},
						success:function(result){
							if(result.success){
								layer.close(index);
								loadTable();
							}else{
								layer.close(index);
								layer.msg(result.msg);
							}
						},
						error : function(errorInfo){
							layer.msg('系统错误！');
						}
					});
				});
			}else if(layEvent === 'reset'){
				layer.confirm('重置后的密码为888888，确定重置密码？', function(index){
					$.ajax({
						type:'POST',
						url:'./user/resetPassWord',
						dataType:'json',
						data:{"userId":data.userId},
						success:function(result){
							if(result.success){
								layer.close(index);
								loadTable();
							}else{
								layer.close(index);
								layer.msg(result.msg);
							}
						},
						error : function(errorInfo){
							layer.msg('系统错误！');
						}
					});
				});
			}
		});
	});
}


$("#addVipmember").click(function(){
	layer.open({
		type : 2,				
		title : '添加会员',
		btnAlign: 'c',
	  	content: './admin/add_vipmember.html',
	  	area : ['713px','700px'],
	  	btn : ['确定','取消'],
	  	yes : function(index, layero){
	  		var body = layer.getChildFrame('body',index);//建立父子联系
            var iframeWin = window[layero.find('iframe')[0]['name']];
           	iframeWin.clickAddUser();
	  	}
	});
});

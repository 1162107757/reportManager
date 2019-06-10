// 发布文章页面
function addArticle(){
	$(".main-content").load("./admin/add_article.html");
}
var totalPage = 0;
$(function(){
	
	// 判断是否存在文章ID
	var articleId = '';
	var url = this.location.search;
	var param = url.replace("?","");
	var keyAndVal = param.split("&");
	for (var i = 0; i < keyAndVal.length; i++) {
		if(keyAndVal[i].indexOf("articleId") != -1){
			articleId = keyAndVal[i].split("=");
		}
	}
	
	if(articleId != ''){
		$(".main-content").load("./admin/articleInfo.html?articleId=" + articleId);
		return;
	}
	// 初次加载第一页
	getArticleList(1,'');
});

// 搜索内容全局变量
var searchText = '';
function searchContent(){
	searchText = $("input[name='searchContent']").val();
	getArticleList(1,searchText);
}

function getArticleList(page,searchText){
	$.ajax({
		type : 'POST',
		url : './article/getArticleList',
		data : {"page":page,"searchContent":searchText},
		dataType : 'json',
		success : function(data){
			totalPage = data.totalPage;
			// 删除子节点
			$(".articleList").empty();
			if(data.data.length > 0){
				for (var i = 0; i < data.data.length; i++) {
					$(".articleList").append(
							'<div class="divpatch">'
							+ '<div style="width: 130px;height: 120px;float: left;margin-right: 20px;background-image: url(https://s1.ax1x.com/2018/08/27/PqyCdS.png);background-size: 130px;"></div>'
							+ '<div>'
							+ '<a href="javascript:void(0);" onclick="articleInfo(\'' + data.data[i].articleId + '\');"><h3>'+ data.data[i].title +'</h3></a>'
							+ '</div>'
							+ '<div style="height: 90px;margin-top: 20px;"><a href="javascript:void();" onclick="articleInfo(\'' + data.data[i].articleId + '\');">' +
							repalceHtml(data.data[i].content.substring(0,50) + "......")
							+ '</a></div>'
							+ '<div style="margin-left: 60%;">'
							+ '<div style="display: inline-block;margin-right: 20px;">'
							+ '<div class="glyphicon glyphicon-eye-open" style="display: inline-block;float: left;margin-top: 2px;margin-right: 5px;"></div><a href="javascript:void();">阅读('+ data.data[i].views +')</a>'
							+ '</div>'
							+ '<div style="display: inline-block;margin-right: 20px;">'
							+ '<div class="glyphicon glyphicon-list-alt" style="display: inline-block;float: left;margin-top: 2px;margin-right: 5px;"></div><a href="javascript:void();">评论('+ data.data[i].views +')</a>'
							+ '</div>'
							/*+ '<div style="display: inline-block;margin-right: 20px;">'
							+ '<div class="glyphicon glyphicon-pencil" style="display: inline-block;float: left;margin-top: 2px;margin-right: 5px;"></div><a href="javascript:void();">管理评论</a>'
							+ '</div>'*/
							+ '<div style="display: inline-block;margin-right: 20px;">'
							+ '<div class="glyphicon glyphicon-remove" style="display: inline-block;float: left;margin-top: 2px;margin-right: 5px;"></div><a href="javascript:void(0);" onclick="delArticle(\'' + data.data[i].articleId + '\');">删除</a>'
							+ '</div>'
							+ '</div>'
					);
				}
			}else{
				$(".articleList").append(
					'<div class="divpatch" align="center" style="background-color: #FFFFFF;color: #A9A9A9;"><div style="display: inline-block;"><h3>未查找到内容......</h3></div></div>'
				);
			}
			// 删除子节点
			$(".page").empty();
			$(".page").append(
				'<nav aria-label="...">'
					+'<ul class="pager">'
						+'<li onclick="getArticleList(' + data.prevPage + ',\'' + searchText + '\');" class="prevPage"><a href="javascript:void(0);">Previous</a></li>'
						+'<li onclick="getArticleList(' + data.nextPage + ',\'' + searchText + '\');" class="nextPage"><a href="javascript:void(0);">Next</a></li>'
					+'</ul>'
				+'</nav>'
			);
			if(data.page <= data.prevPage){
				$(".prevPage").addClass("disabled");
				$(".prevPage").removeAttr("onclick");
			}
			if(data.page >= data.nextPage){
				$(".nextPage").addClass("disabled");
				$(".nextPage").removeAttr("onclick");
			}
		}
	});
	
	// 锚点调至顶端
	$('body,html').animate({scrollTop: $('#wrapper').offset().top}, 300);
}

// 去掉html标签的内容
function repalceHtml(html){
	var html = html.replace(/<\/?.+?>/g,"");
	var content = html.replace(/ /g,"");//得到后的内容
	return content;
}

function delArticle(articleId){
	var array = new Array();
	array.push(articleId);
	layer.confirm('是否删除这篇文章？', function(index){
		layer.load();
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : './article/delArticle',
			contentType : 'application/json',
			data : JSON.stringify(array),
			success : function(data){
				if(data.success){
					layer.closeAll('loading');
					layer.msg(data.msg);
					setTimeout(function(){
						window.location.reload();
					},2000);
				}else{
					layer.closeAll('loading');
					layer.msg(data.msg);
				}
			}
		});
		layer.close(index);
	});
}

function articleInfo(articleId){
	// 得到标签ID
	var id = $(".active").attr("id");
	// 重定向附上ID
	window.location.href="index?loginCode=admin&pageCode=" + id + "&articleId=" + articleId;
	// 加载页面
}

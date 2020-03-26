<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html class="ui-page-login">
<base href="<%=basePath%>">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<title>车型查找</title>
	<link href="lib/mui/css/mui.indexedlist.css" rel="stylesheet" />
	<style>
		#vehicle-page {
			height: 100%;
			width: 100%;
		}

		#vehicle-page .car-infos-title {
			line-height: 40px;
			height: 40px;
			border-bottom: 1px solid #d4d4d4;
		}

		#vehicle-page .car-infos-title span {
			font-weight: bold;
			font-size: 16px;
			line-height: 40px;
			text-align: left;
			vertical-align: top;
			color: #424242;
		}

		#vehicle-page .car-infos-title img {
			width: 20px;
			height: 20px;
			margin-top: 10px;
			margin-left: 10px;
			margin-right: 5px;
		}

		#vehicle-page .car-categorys {
			width: 100%;
		}

		#vehicle-page .car-categorys .car-category {
			width: calc(25% - 20px);
			min-width: 60px;
			text-align: center;
			line-height: 30px;
			height: 30px;
			margin: 8px;
			display: inline-block;
			border-radius: 6px;
			background-color: #e4e4e4;
			font-size: 15px;
		}

		#vehicle-page .car-categorys .car-category.active {
			background: #0367fd;
			color: white;
		}


		#vehicle-page .mui-grid-view.mui-grid-9 .mui-table-view-cell {
			padding: 0px;
		}

		#vehicle-page .mui-grid-view.mui-grid-9 .mui-table-view-cell > a:not(.mui-btn) {
			padding: 5px 0px;
		}

		#vehicle-page .brand-item-img {
			border: 1px solid #e2e2e2;
			border-radius: 4px;
			box-shadow: 0 0 10px 0px #b3b2b2;
			background-color: white;
		}

		#vehicle-page .brand-item-img img {
			display: block;
			height: 55px;
			max-height: 60px;
			width: auto;
			max-width: 100%;
			margin: 0 auto;
		}

		#vehicle-page .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
			margin-top:3px;
			padding-left: 3px;
			padding-right: 3px;
			font-size: 13px;
		}

		#vehicle-page .empty-tips {
			display: none;
			margin: calc(50% - 50px) auto;
			width: 180px;
			height: auto;
		}

		#vehicle-page .mui-table-view-cell > a:not(.mui-btn).mui-active {
			background-color: transparent;
		}

		#vehicle-page .mui-grid-view.mui-grid-9 {
			background-color: transparent;
		}
	</style>
	<style>
		#vehicle-page .mui-backdrop {
			display: none;
			top: 0px;
			left: 0px;
			bottom: 0px;
			right: 0px;
			padding: 30px 25px;
		}

		#vehicle-page .search-box .mui-card {
			height: 100%;
			width: 100%;
			margin: 0;
			overflow: visible;
		}

		#vehicle-page .search-box .img-btn-close {
			position: absolute;
			right: -10px;
			top: -10px;
			width: 30px;
			height: 30px;
			border-radius: 50%;
			border: 1px solid #ddd;
			background-color: white;
			background-image: url("image/btn_close.png");
			background-position: center;
			background-size: 100%;
		}

		#vehicle-page .search-box .mui-card-content {
			height: calc(100% - 50px);
			overflow-y: auto;
			overflow-x: hidden;
		}

		#vehicle-page .mui-ios .mui-indexed-list-empty-alert, .mui-indexed-list-empty-alert {
			padding: 40px 15px !important;
		}

		#vehicle-page #search-box .mui-list-load-more {
			display: none;
			width: 100%;
			border-radius: unset;
			border-left: none;
			border-right: none;
		}
	</style>
</head>
<body>
<div id="vehicle-page">
	<div class="brand-box">
		<div class="car-infos-title"><img src="image/wx/icon_car.png"/><span>选择车系</span>
			<span class="mui-icon mui-icon-search mui-pull-right" onclick="$('#search-box').fadeIn();"
				  style="margin-right: 10px;font-size: 22px"></span>
		</div>
		<div id="car-categorys" class="car-categorys">
			<c:forEach items="${categorys}" var="cate" varStatus="i">
				<div class="car-category ${i.first ? 'active' : ''}" data-id="${cate.id}">${cate.category}</div>
			</c:forEach>
		</div>
		<div class="car-infos-title"><img src="image/wx/icon_car.png"/><span>选择品牌</span></div>
		<ul id="car-brands" class="mui-table-view mui-grid-view mui-grid-9" style="padding:10px;"></ul>
		<img class="empty-tips" src="image/no_datas.png"/>
	</div>
	<div id="search-box" class="search-box mui-backdrop">
		<div class="mui-card">
			<div class="mui-card-header">
				<span class="img-btn-close" onclick="searchHide();"></span>
				<div class="mui-indexed-list-search mui-input-row mui-search">
					<input id="search" type="search" class="mui-input-clear mui-indexed-list-search-input"
						   placeholder="搜索车型关键字并以空格分隔">
					<input id="search-page" type="hidden" value="1"/>
				</div>
			</div>
			<div class="mui-card-content">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<ul class="mui-table-view"></ul>
					</div>
				</div>
				<div class="mui-indexed-list-empty-alert">没有数据</div>
			</div>
		</div>
	</div>
</div>
</body>

<script type="text/x-jsrender" id="searchListBoxTpl">
	{{for}}
		<li data-value="{{:firstChar}}" class="mui-table-view-cell mui-media">
			<a href="wechat/carModel/model/">
				<div class="mui-media-body mui-navigate-right">{{:modelName}}</div>
			</a>
		</li>
	{{/for}}
</script>
<script type="text/x-jsrender" id="carModelListBoxTpl">
{{for}}
	<li class="mui-table-view-cell mui-media mui-col-xs-3 mui-col-sm-2">
		<a href="wechat/carModel/series/{{:id}}.do?name={{:brandName}}" data-name="{{:brandName}}">
			<span class="mui-icon brand-item-img"><img src="mobile/shop/getImage.do?path=car/{{:logoUrl}}" onerror="this.onerror='';this.src='image/no_picture.jpg'"></span>
			<div class="mui-media-body">{{:brandName}}</div>
		</a>
	</li>
{{/for}}
</script>

<script type="text/javascript">
	mui.init({
		swipeBack:true,
	});
	mui.ready(function () {
		renderCarBrandView();
		mui('body').on('tap', '#vehicle-page .brand-item a', function () {
			window.top.location.href=this.href;
		}).on('tap', '#vehicle-page .car-category', function () {
			$("#vehicle-page .car-categorys .car-category").removeClass("active");
			$(this).addClass("active");
			renderCarBrandView();
		});

		document.getElementById("search").addEventListener("keypress", function (event) {
			if (event.keyCode == "13" || event.key == "Enter") {
				document.activeElement.blur();//收起虚拟键盘
				searchModelData();
				event.preventDefault(); // 阻止默认事件---阻止页面刷新
			}
		});
		mui(document.body).on('tap', '#vehicle-page .mui-list-load-more', function (e) {
			var me = this;
			if ($(me).hasClass("none-data")) {
				$(me).text("已加载全部");
			} else {
				mui(me).button('loading');
				var page = $("#search-box #search-page").val() * 1 + 1;
				mui.ajax("wechat/community/car/search.do", {
					data: {search: $("#search-box #search").val(), page: page, limit: 20},
					dataType: 'json',
					type: 'post',
					timeout: 10000,
					success: function (res) {
						$("#vehicle-page #search-box #search-page").val(page);
						if (res == null || res.length == 0) {
							$(me).text("已加载全部");
							$(me).addClass("none-data");
						} else {
							$(me).text("加载更多");
							$(me).removeClass("none-data");
							var html = $("#searchListBoxTpl").render(res);
							$("#vehicle-page #search-box .mui-table-view").append(html);
						}
						mui(me).button('reset');
					},
					error: function (xhr, type, errorThrown) {
						$(me).text("加载失败, 请重试!");
						mui(me).button('reset');
					}
				});
			}
		});

	});

	/**
	 * 根据车系修改品牌列表
	 * @param category
	 */
	function renderCarBrandView() {
		var id = $("#vehicle-page .car-categorys .car-category.active").attr("data-id");
		mui.post('wechat/community/car/brands.do',{category : id},function(data){
			$("#vehicle-page #car-brands").empty();
			if(data == null || data.length == 0){
				$("#vehicle-page .empty-tips").css("display", "block");
				$("#vehicle-page #car-brands").css("display", "none");
				return;
			}else{
				$("#vehicle-page .empty-tips").css("display", "none");
				$("#vehicle-page #car-brands").css("display", "block");
			}
			var html = $("#carModelListBoxTpl").render(data);
			$("#vehicle-page #car-brands").append(html);
		});
	}
	function renderSearchView(data) {
		return $("#searchListBoxTpl").render(data);
	}
	(function($) {
		var queryLimit = 20;

		$('#vehicle-page #search-box .mui-scroll-wrapper').scroll({
			bounce: false,
			indicators: true, //是否显示滚动条
			deceleration: mui.os.ios ? 0.003 : 0.003 //阻尼系数
		});

		var createHtml = function(element, index, limit, down) {
			var page = down ? 1 : (element.getAttribute("data-page") || 0) * 1 + 1;
			element.setAttribute("data-page", page);
			var input = $("#vehicle-page #search-box #search").value;
			var data = [];
			mui.ajax('wechat/community/car/search.do',{
				async: false,
				data: {search: input, page: 1, limit: 20},
				type: 'post',
				dataType: 'json',
				timeout: 10000,
				success: function(res){data = res;},
				error: function(xhr, type, errorThrown){console.log(type);}
			});
			//console.log("index: "+index, "limit: "+limit, "type: "+type, "page: "+page);
			return renderSearchView(data);
		};
		//循环初始化所有下拉刷新，上拉加载。
		$.ready(function() {
			$.each(document.querySelectorAll('#vehicle-page #search-box .mui-scroll'), function(index, pullRefreshEl) {
				$(pullRefreshEl).pullToRefresh({
					down: {
						callback: function() {
							var self = this;
							setTimeout(function() {
								var ul = self.element.querySelector('.mui-table-view');
								ul.innerHTML = createHtml(self.element.parentNode.parentElement, index, queryLimit, true);
								self.endPullDownToRefresh();
								self.refresh(true);
							}, 1000);
						}
					},
					up: {
						callback: function() {
							var self = this;
							setTimeout(function() {
								var ul = self.element.querySelector('.mui-table-view');
								var html = createHtml(self.element.parentNode.parentElement, index, queryLimit);
								ul.innerHTML += html;
								self.endPullUpToRefresh(html == null || html.length == 0);
							}, 1000);
						},
						auto: true
					}
				});
			});
		});

	})(mui);

	// 检索车型
	function searchModelData() {
		$("#vehicle-page #search-box #search-page").val(1);
		$("#vehicle-page #search-box .mui-table-view").empty();
		var input = $("#vehicle-page #search-box #search").val();

		mui.post("wechat/community/car/search.do", {
			search: input, page: 1, limit: 20
		}, function (res) {
			if (res == null || res.length == 0) {
				$("#vehicle-page #search-box .mui-indexed-list-empty-alert").show();
			} else {
				$("#vehicle-page #search-box .mui-indexed-list-empty-alert").hide();
				var html = $("#vehicle-page #searchListBoxTpl").render(res);
				$("#vehicle-page #search-box .mui-table-view").append(html);
				$("#vehicle-page #search-box button.mui-list-load-more").show();
				if (res.length < 20) {
					$("#vehicle-page #search-box button.mui-list-load-more").addClass("none-data");
					$("#vehicle-page #search-box button.mui-list-load-more").text("已加载全部");
				}
			}
		});
	}
	function searchHide() {
		$('#search-box').fadeOut();
		$("#search-box #search-page").val(1);
		$("#search-box #search").val("");
		$("#search-box ul.mui-table-view").empty();
		$("#search-box button.mui-list-load-more").hide();
		$("#search-box .mui-search").removeClass("mui-active");
	}
</script>
</html>

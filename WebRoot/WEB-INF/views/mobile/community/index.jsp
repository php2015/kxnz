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
	<meta name="viewport"
		content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<title>连途社区</title>
	<link href="lib/mui/css/mui.min.css" rel="stylesheet" />
	<link href="lib/mui/css/mui-icons-extra.css" rel="stylesheet" />
	<link href="lib/mui/css/app.css" rel="stylesheet" />
	<script src="lib/mui/js/mui.js"></script>
	<script src="lib/jquery/jquery-3.4.1.js"></script>
	<script src="lib/jquery/jsrender.js"></script>
	<style>
		* { touch-action: pan-y; }
		.float-left {
			float: left;
		}

		.float-right {
			float: right;
		}

		.clear-float {
			clear: both;
		}
		html, body{
			height: 100%;
			width: 100%;
		}
		#mui-content .mui-control-content{
			height: 100%;
		}

		#mui-content .mui-bar-tab ~ #mui-content {
			padding-bottom: 50px !important;
		}

		.mui-control-content {
			overflow-y: auto;
			overflow-x: hidden;
		}

		li.mui-table-view-cell {
			font-size: 13px;
		}

		li.mui-table-view-cell .mui-navigate-right {
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
			margin-right: 10px;
		}
	</style>
	<%--consultation--%>
	<style>
		#consultation .video-type-image{
			max-height: 50px;
			width: auto;
		}
		#consultation .mui-scroll-wrapper .mui-scroll{
			width: 100%;
		}
		#consultation .video-type-text{
			font-size: 12px;
			margin-top: 3px;
		}
		@media (min-width: 320px){
			#consultation .video-type .mui-table-view-cell {
				width: 25%;
			}
			#consultation .video-type .mui-table-view-cell .video-type-image{
				max-height:45px
			}
		}
		@media (min-width: 370px){
			#consultation .video-type .mui-table-view-cell {
				width: 20%;
			}
			#consultation .video-type .mui-table-view-cell .video-type-image{
				max-height:50px
			}
		}

		#consultation .video-list{
			position: relative;
			height: 100%;
			border-top: 1px solid #d6d6d6;
		}

		#consultation .video-list .mui-table-view-cell {
			padding-left: 10px;
			padding-right: 10px;
		}

		#consultation .video-list .mui-media-body {
			height: 85px;
			padding: 5px 0;
		}

		#consultation .video-list .car-video-image {
			width: 120px;
			height: 100%;
			float: left;
			border: 1px solid #bdbdbd;
			border-radius: 2px;
		}

		#consultation .video-list .car-video-body {
			height: 100%;
			width: calc(100% - 130px);
			margin: 0 5px;
		}

		#consultation .video-list .car-video-body .car-video-title {
			font-weight: bold;
			font-size: 14px;
			height: 25px;
			line-height: 25px;
		}

		#consultation .video-list .car-video-body .car-video-describe {
			font-weight: normal;
			font-size: 12px;
			color: #bababa;
			height: 25px;
			line-height: 25px;
		}

		#consultation .video-list .car-video-body .car-video-other div {
			font-weight: normal;
			font-size: 11px;
			color: #9e9e9e;
			height: 25px;
			margin-right: 5px;
			line-height: 35px;
		}

		#consultation .video-list .car-video-body .car-video-other .mui-icon {
			font-size: 13px;
			margin-right: 2px;
		}
		#consultation .video-list .member-0 .car-video-title:before {
			content: "免费";
			color: white;
			background-color: #a2a2a2;
			padding: 3px 6px;
			border-radius: 3px;
			font-size: 11px;
			font-weight: normal;
			margin-right: 4px;
		}

		#consultation .video-list .member-1 .car-video-title:before {
			content: "VIP";
			color: white;
			background-color: #ffbf48;
			padding: 3px 6px;
			border-radius: 3px;
			font-size: 12px;
			font-weight: normal;
			margin-right: 4px;
		}

		#consultation .video-list .member-2 .car-video-title:before {
			content: "付费";
			color: white;
			background-color: #70df5a;
			padding: 3px 6px;
			border-radius: 3px;
			font-size: 12px;
			font-weight: normal;
			margin-right: 4px;
		}
	</style>
	<%--vehicle--%>
	<style>
		#vehicle {
			height: 100%;
			width: 100%;
		}

		#vehicle .car-infos-title {
			line-height: 40px;
			height: 40px;
			border-bottom: 1px solid #d4d4d4;
		}

		#vehicle .car-infos-title span {
			font-weight: bold;
			font-size: 16px;
			line-height: 40px;
			text-align: left;
			vertical-align: top;
			color: #424242;
		}

		#vehicle .car-infos-title img {
			width: 20px;
			height: 20px;
			margin-top: 10px;
			margin-left: 10px;
			margin-right: 5px;
		}

		#vehicle .car-categorys {
			width: 100%;
		}

		#vehicle .car-categorys .car-category {
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

		#vehicle .car-categorys .car-category.active {
			background: #0367fd;
			color: white;
		}


		#vehicle .mui-grid-view.mui-grid-9 .mui-table-view-cell {
			padding: 0px;
		}

		#vehicle .mui-grid-view.mui-grid-9 .mui-table-view-cell > a:not(.mui-btn) {
			padding: 5px 0px;
		}

		#vehicle .brand-item-img {
			border: 1px solid #e2e2e2;
			border-radius: 4px;
			box-shadow: 0 0 10px 0px #b3b2b2;
			background-color: white;
		}

		#vehicle .brand-item-img img {
			display: block;
			height: 55px;
			max-height: 60px;
			width: auto;
			max-width: 100%;
			margin: 0 auto;
		}

		#vehicle .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
			margin-top:3px;
			padding-left: 3px;
			padding-right: 3px;
			font-size: 13px;
		}

		#vehicle .empty-tips {
			display: none;
			margin: calc(50% - 50px) auto;
			width: 180px;
			height: auto;
		}

		#vehicle .mui-table-view-cell > a:not(.mui-btn).mui-active {
			background-color: transparent;
		}

		#vehicle .mui-grid-view.mui-grid-9 {
			background-color: transparent;
		}
	</style>
	<%--搜索功能--%>
	<style>
		#search-box{
			display: none;
			padding: 40px 25px;
		}
		#search-box .mui-scroll-wrapper .mui-pull-top-pocket.mui-block{
			background: white;
		}
		#search-box .mui-card{
			height: 100%;
			margin: 0px;
			border-radius: 5px;
			overflow: visible;
		}
		#search-box .img-btn-close {
			position: absolute;
			right: -15px;
			top: -15px;
			width: 30px;
			height: 30px;
			border-radius: 50%;
			border: 1px solid #ddd;
			background-color: white;
			background-image: url('image/btn_close.png');
			background-position: center;
			background-size: 100%;
			z-index: 10000;
		}
		#search-box .mui-empty-alert{

			text-align: center;
			line-height: 60px;
			color: #4f4f4f;
			font-size: 16px;
			font-family: "Helvetica Neue", Helvetica, "PingFang SC", 微软雅黑, Tahoma, Arial, sans-serif;
			letter-spacing: 5px;
		}
		#search-box .mui-search{
			margin-bottom: -12px
		}
		#search-box .mui-card-content{
			height: calc(100% - 57px);
		}
	</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav">
		<%--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>--%>
		<h1 class="mui-title">连途社区</h1>
		<span id="search-trigger" class="mui-icon mui-icon-search mui-pull-right"></span>
	</header>
	<nav class="mui-bar mui-bar-tab">
		<a class="mui-tab-item mui-active" href="#consultation" data-id="consultation">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label" data-title="连途社区">首页</span>
		</a>
		<a class="mui-tab-item" href="#vehicle" data-id="vehicle">
			<span class="mui-icon mui-icon-extra mui-icon-extra-xiaoshuo"></span>
			<span class="mui-tab-label" data-title="车型查找">车型</span>
		</a>
		<a class="mui-tab-item" href="#mine" data-id="mine">
			<span class="mui-icon mui-icon-contact"></span>
			<span class="mui-tab-label" data-title="个人中心">我的</span>
		</a>
	</nav>

	<div id="mui-content" class="mui-content">
		<%--社区首页--%>
		<div id="consultation" class="mui-control-content mui-active">
			<div id="banner-slider" class="mui-slider" style="height: 160px; ${empty banners ? 'display:none':''}">
				<div class="mui-slider-group mui-slider-loop">
					<c:forEach items="${banners}" var="item" varStatus="i">
						<div class="mui-slider-item ${(i.first || i.end) ? 'mui-slider-item-duplicate' : ''}">
							<a href="${item.href}"><img src="${item.value}"/></a>
						</div>
					</c:forEach>
				</div>
				<div class="mui-slider-indicator">
					<c:forEach items="${banners}" varStatus="i">
						<div class="mui-indicator ${i.first ? 'mui-active' : ''}"></div>
					</c:forEach>
				</div>
			</div>
			<%--视频类型--%>
			<div class="video-type">
				<ul id="video-type-ul" class="mui-table-view mui-grid-view mui-row" style="padding:0 10px 10px 10px;">
					<c:forEach items="${videoClass}" var="item" varStatus="i">
						<li class="mui-table-view-cell" data-class-id="${item.id}" data-title="${item.name}">
							<a href="javascript:void(0)">
								<img class="mui-media-object video-type-image" src="${item.imgUrl}" onerror="this.onerror='';this.src='image/no_picture.jpg'">
								<div class="mui-media-body video-type-text">${item.name}</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<%--视频列表--%>
			<div class="video-list ">
				<div class="mui-scroll-wrapper">
					<div id="itemVideoListHot" class="mui-scroll" data-type="Hot">
						<ul class="mui-table-view">
							<c:forEach items="${hotVideos}" var="item">
								<li class="mui-table-view-cell mui-media member-${item.member}" data-id="${item.id}" data-member="${item.member}">
									<a href="javascript:void(0)">
										<div class="mui-media-body mui-navigate-right">
											<img class="car-video-image float-left" src="mobile/shop/getImage.do?path=${item.coverUrl}"
												 onerror="this.onerror='';this.src='image/no_picture.jpg'"/>
											<div class="car-video-body float-right">
												<div class="car-video-title">${item.title}</div>
												<div class="car-video-describe">${item.describe}</div>
												<div class="car-video-other">
													<div class="car-video-browse float-left">
														<span class="mui-icon mui-icon-extra mui-icon-extra-rank"></span>${item.browseNum}</div>
													<div class="car-video-collect float-left">
														<span class="mui-icon mui-icon-extra mui-icon-extra-heart"></span>${item.collectNum}
													</div>
													<div class="car-video-time float-right">${item.createTime}</div>
												</div>
											</div>
											<div class="clear-float"></div>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div id="vehicle" class="mui-control-content">
			<div class="brand-box">
				<div class="car-infos-title"><img src="image/wx/icon_car.png"/><span>选择车系</span></div>
				<div id="car-categorys" class="car-categorys">
					<c:forEach items="${categorys}" var="cate" varStatus="i">
						<div class="car-category ${i.first ? 'active' : ''}" data-id="${cate.id}">${cate.category}</div>
					</c:forEach>
				</div>
				<div class="car-infos-title"><img src="image/wx/icon_car.png"/><span>选择品牌</span></div>
				<ul id="car-brands" class="mui-table-view mui-grid-view mui-grid-9" style="padding:10px;"></ul>
				<img class="empty-tips" src="image/no_datas.png"/>
			</div>
		</div>
		<div id="mine" class="mui-control-content"></div>
	</div>
	<%--检索车型--%>
	<div id="search-box" class="mui-backdrop">
		<div class="mui-card">
			<div class="mui-card-header">
				<div class="mui-input-row mui-search" style="width: 100%">
					<input id="search-text" type="search" class="mui-input-clear mui-indexed-list-search-input"
						   placeholder="搜索车型关键字并以空格分隔">
				</div>
				<span class="img-btn-close"></span>
			</div>
			<div class="mui-card-content">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<ul class="mui-table-view"></ul>
					</div>
				</div>
				<div class="mui-empty-alert">没有数据</div>
			</div>
		</div>
	</div>
<script type="text/x-jsrender" id="consultationVideoListBoxTpl">
{{for}}
	<li class="mui-table-view-cell mui-media member-{{:member}}" data-id="{{:id}}">
		<a href="javascript:void(0)">
			<div class="mui-media-body mui-navigate-right">
				<img class="car-video-image float-left" src="mobile/shop/getImage.do?path={{:coverUrl}}"
					 onerror="this.onerror='';this.src='image/no_picture.jpg'"/>
				<div class="car-video-body float-right">
					<div class="car-video-title">{{:title}}</div>
					<div class="car-video-describe">{{:describe}}</div>
					<div class="car-video-other">
						<div class="car-video-browse float-left">
							<span class="mui-icon mui-icon-extra mui-icon-extra-rank"></span>{{:browseNum}}</div>
						<div class="car-video-collect float-left">
							<span class="mui-icon mui-icon-extra mui-icon-extra-heart"></span>{{:collectNum}}
						</div>
						<div class="car-video-time float-right">{{:createTime}}</div>
					</div>
				</div>
				<div class="clear-float"></div>
			</div>
		</a>
	</li>
{{/for}}
</script>
<script type="text/x-jsrender" id="vehicleCarModelListBoxTpl">
{{for}}
	<li class="mui-table-view-cell mui-media mui-col-xs-3 mui-col-sm-2">
		<a href="wechat/community/car/series/{{:id}}.do" data-name="{{:brandName}}">
			<span class="mui-icon brand-item-img"><img src="mobile/shop/getImage.do?path=car/{{:logoUrl}}" onerror="this.onerror='';this.src='image/no_picture.jpg'"></span>
			<div class="mui-media-body">{{:brandName}}</div>
		</a>
	</li>
{{/for}}
</script>
<script type="text/x-jsrender" id="searchListBoxTpl">
	{{for}}
		<li data-value="{{:firstChar}}" class="mui-table-view-cell mui-media">
			<a href="wechat/carModel/model/">
				<div class="mui-media-body mui-navigate-right">{{:modelName}}</div>
			</a>
		</li>
	{{/for}}
</script>
</body>
<script type="text/javascript">

	var queryLimit = 20, hotVideoPage = 1, searchModelPage = 1;

	$("#mui-content").css("height", $("body").height() + "px");
	var activeTab = document.querySelector('.mui-tab-item.mui-active').getAttribute('data-id');
	// 点击切换，动态创建其它webview；
	mui(document.body).on('tap', 'nav.mui-bar-tab a.mui-tab-item', function(e) {
		var targetTab = this.getAttribute('data-id');
		if(targetTab === activeTab) {
			return;
		}
		$("header.mui-bar.mui-bar-nav .mui-title").html($(this).find(".mui-tab-label").attr("data-title"));
		activeTab = targetTab;
	}).on('tap', '#vehicle #car-brands li a', function () {
		console.log('tap #vehicle .brand-item a')
		mui.openWindow({
			url: this.href,
			id: this.href,
			styles: {
				titleNView: {
					titleText: this.getAttribute("data-name"),
					titleColor:"#000000",
					titleSize:"17px",
					backgroundColor:"#F7F7F7",
					progress:{
						color:"#00FF00",
						height:"2px"
					},
					splitLine:{
						color:"#CCCCCC",
						height:"1px"
					}
				}
			}
		});
	}).on('tap', '#vehicle .car-category', function () {
		$("#vehicle .car-categorys .car-category").removeClass("active");
		$(this).addClass("active");
		renderCarBrandView();
	}).on('tap', '#search-trigger', function () {
		$("#search-box").fadeIn('fast');
	}).on('tap', '#search-box .img-btn-close', function () {
		$('#search-box').fadeOut('fast',function () {
			$("#search-box #search-text").val("");
			$("#search-box ul.mui-table-view").empty();
			$("#search-box .mui-search").removeClass("mui-active");
			$("#search-box .mui-empty-alert").show();
		});
	}).on('tap', '#consultation .video-list .mui-table-view-cell', function () {
		var self = this;
		var videoId = this.getAttribute("data-id");
		mui.openWindow({
			url: "wechat/community/video/toVideoPlayer.do?videoId="+videoId,
			id: "toVideoPlayer",
			styles: {
				titleNView: {
					titleText: self.getAttribute("data-name"),
					titleColor:"#000000",
					titleSize:"17px",
					backgroundColor:"#F7F7F7",
					progress:{
						color:"#00FF00",
						height:"2px"
					},
					splitLine:{
						color:"#CCCCCC",
						height:"1px"
					}
				}
			},
			extras:{
				brand: self.getAttribute("data-name")
			}
		});
	}).on('tap', '#consultation .video-type .mui-table-view-cell',function () {
		var classId = this.getAttribute("data-class-id");
		var title = this.getAttribute("data-title");
		mui.openWindow({
			url: 'wechat/community/video/typeVideoList.do?classId='+classId+'&title='+title,
			waiting:{
				autoShow:true,//自动显示等待框，默认为true
				title:'正在加载...',//等待对话框上显示的提示内容
				options:{
					width:100,//等待框背景区域宽度，默认根据内容自动计算合适宽度
					height:100,//等待框背景区域高度，默认根据内容自动计算合适高度
				}
			}
		})
	});

	// 加载首页视频列表
	var createConsultationHtml = function(isDown) {
		hotVideoPage = isDown ? 1 : hotVideoPage + 1;
		var data = [];
		mui.ajax('wechat/community/video/indexList.do',{
			async: false,
			data: {type: 'hot', page: hotVideoPage, limit: queryLimit},
			type: 'post',
			dataType: 'json',
			timeout: 10000,
			success: function(res){data = res;},
			error: function(xhr, type, errorThrown){console.error('query index video list error');}
		});
		return $("#consultationVideoListBoxTpl").render(data);
	};

	// 加载汽车品牌
	var renderCarBrandView = function(){
		var id = $("#vehicle .car-categorys .car-category.active").attr("data-id");
		mui.post('wechat/community/car/brands.do',{category : id},function(data){
			$("#vehicle #car-brands").empty();
			if(data == null || data.length == 0){
				$("#vehicle .empty-tips").css("display", "block");
				$("#vehicle #car-brands").css("display", "none");
				return;
			}else{
				$("#vehicle .empty-tips").css("display", "none");
				$("#vehicle #car-brands").css("display", "block");
			}
			$("#vehicle #car-brands").append($("#vehicleCarModelListBoxTpl").render(data));
		});
	};
	/**
	 * describe: 车型模糊检索
	 * creat_user: xyang
	 * @param isSearch 是否为刷新
	 * date: 2020/3/25 0025 15:29
	 **/
	var searchModelData = function(isSearch) {
		$("#search-box .mui-empty-alert").hide();
		searchModelPage = isSearch ? 1 : searchModelPage + 1;
		var input = $("#search-box #search-text").val();
		var data = [];
		mui.ajax('wechat/community/car/search.do',{
			async: false,
			data: {search: input, page: searchModelPage, limit: queryLimit},
			type: 'post',
			dataType: 'json',
			timeout: 10000,
			success: function(res){
				if(isSearch && (res == null || res.length == 0)){
					$("#search-box .mui-empty-alert").show();
				}
				data = res;
			}, error: function(xhr, type, errorThrown){console.error('search car model list error');}
		});
		return $("#searchListBoxTpl").render(data);
	}

	mui.init({
		swipeBack:true,
		pullRefresh : {
			snap: true,
			container:"#consultation .video-list>div",//下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等
			down : {
				style:'circle',//必选，下拉刷新样式，目前支持原生5+ ‘circle’ 样式
				color:'#2BD009', //可选，默认“#2BD009” 下拉刷新控件颜色
				height: 20,//可选,默认50px.下拉刷新控件的高度,
				contentdown : "下拉可以刷新",
				contentover : "释放立即刷新",
				contentrefresh : "正在刷新...",
				auto: false,//可选,默认false.首次加载自动上拉刷新一次
				callback : function () {
					this.element.querySelector('.mui-table-view').innerHTML = createConsultationHtml(true);
					this.endPulldownToRefresh()
				}
			},
			up : {
				height:20,//可选.默认50.触发上拉加载拖动距离
				auto:false,//可选,默认false.自动上拉加载一次
				contentrefresh : "正在加载...",//可选，正在加载状态时，上拉加载控件上显示的标题内容
				contentnomore:'没有更多数据了',//可选，请求完毕若没有更多数据时显示的提醒内容；
				callback: function () {
					var html = createConsultationHtml();
					var ul = this.element.querySelector('.mui-table-view').innerHTML += html;
					this.endPullupToRefresh(html == null || html.length == 0);
				}
			}
		}
	})
	mui.ready(function(){
		// 根据页面大小, 重新设置视频列表高度
		var videoListHeight = $("#consultation").height() - $("#consultation #banner-slider").outerHeight() - 170;
		$("#consultation .video-list").css("height", videoListHeight +"px");
		renderCarBrandView();

		//可多次调用
		mui("#search-box .mui-scroll-wrapper").pullRefresh({
			down: {
				style:'circle',//必选，下拉刷新样式，目前支持原生5+ ‘circle’ 样式
				color:'#2BD009', //可选，默认“#2BD009” 下拉刷新控件颜色
				height: 20,//可选,默认50px.下拉刷新控件的高度,
				contentdown : "下拉可以刷新",
				contentover : "释放立即刷新",
				contentrefresh : "正在刷新...",
				auto: true,//可选,默认false.首次加载自动上拉刷新一次
				callback: function () {
					this.element.querySelector('.mui-table-view').innerHTML = searchModelData(true);
					this.endPulldownToRefresh()
				}
			},
			up: {
				height:20,//可选.默认50.触发上拉加载拖动距离
				auto:false,//可选,默认false.自动上拉加载一次
				contentrefresh : "正在加载...",//可选，正在加载状态时，上拉加载控件上显示的标题内容
				contentnomore:'没有更多数据了',//可选，请求完毕若没有更多数据时显示的提醒内容；
				callback: function () {
					var html = searchModelData()
					this.element.querySelector('.mui-table-view').innerHTML += html;
					this.endPullupToRefresh(html == null || html.length == 0);
				}
			},
		});

		$("#search-box #search-text").on("change", function () {
			var $search = $("#search-box .mui-scroll-wrapper .mui-table-view");
			$search.empty();
			$search.append(searchModelData(true));
		});
	})

</script>
</html>



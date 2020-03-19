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
	<title></title>
	<link href="lib/mui/css/mui.min.css" rel="stylesheet" />
	<link href="lib/mui/css/style.css" rel="stylesheet" />
	<script src="lib/mui/js/mui.min.js"></script>
	<script src="lib/jquery/jquery-3.4.1.js"></script>
	<script src="lib/jquery/jsrender.js"></script>

	<style>
		.car-infos-title{
			line-height: 40px;
			height: 40px;
			border-bottom: 1px solid #d4d4d4;
		}
		.car-infos-title span{
			font-weight: bold;
			font-size: 16px;
			line-height: 40px;
			text-align: left;
			vertical-align: top;
			color: #424242;
		}
		.car-infos-title img{
			width: 20px;
			height: 20px;
			margin-top: 10px;
			margin-left: 10px;
			margin-right: 5px;
		}

		.car-categorys{
			width: 100%;
		}
		.car-categorys .car-category{
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
		.car-categorys .car-category.active{
			background: #0367fd;
			color: white;
		}

		.brand-item {
			display: inline-block;
			width: calc(20% - 4px);
			height: auto;
			padding: 0;
			margin: 0;
		}
		.brand-item a{
			margin: 0 !important;
		}
		.brand-item .brand-item-img{
			margin: 5px;
			border: 1px solid #e2e2e2;
			border-radius: 4px;
			box-shadow: 0 0 10px 0px #b3b2b2
		}
		.brand-item .brand-item-img img{
			display: block;
			height: 50px;
			max-height: 60px;
			width: auto;
			max-width: 100%;
			margin: 0 auto;
		}
		.brand-item .mui-media-body{
			margin: 0;
			text-align: center;
			font-size: 13px;
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
		.mui-table-view-cell:after{
			background: transparent;
		}
		.empty-tips{
			display: none;
			margin: calc(50% - 50px) auto;
			width: 180px;
			height: auto;
		}
		.mui-table-view-cell>a:not(.mui-btn).mui-active{
			background-color: transparent;
		}
	</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
		<h1 class="mui-title">品牌厂家选择</h1>
	</header>
	<div class="mui-content" style="background-color: white">
		<div class="car-infos-title"><img src="image/wx/icon_car.png"/><span>选择车系</span></div>
		<div class="car-categorys">
			<c:forEach items="${categorys}" var="cate" varStatus="i">
				<div class="car-category ${i.first ? 'active' : ''}" data-id="${cate.id}">${cate.category}</div>
			</c:forEach>
		</div>
		<div class="car-infos-title"><img src="image/wx/icon_car.png"/><span>选择品牌</span></div>
		<ul id="car-brands" class="mui-table-view" style="padding:10px;"></ul>
		<img class="empty-tips" src="image/no_datas.png"/>
	</div>
</body>
</html>

<script type="text/x-jsrender" id="boxTpl">
{{for}}
	<li class="mui-table-view-cell mui-media brand-item">
		<a href="wechat/carModel/series/{{:id}}.do?name={{:brandName}}">
			<div class="brand-item-img"><img src="mobile/shop/getImage.do?path=car/{{:logoUrl}}" onerror="this.onerror='';this.src='image/no_picture.jpg'"></div>
			<div class="mui-media-body">{{:brandName}}</div>
		</a>
	</li>
{{/for}}
</script>
<script type="text/javascript">
	initModule();

	/**
	 * 初始化模块
	 *
	 */
	function initModule(){
		bindEvent();
	}

	/**
	 * 绑定事件
	 *
	 */
	function bindEvent(){
		renderCarBrandView();

		mui('body').on('tap','.brand-item a',function(){
			window.top.location.href=this.href;
		}).on('tap', '.car-category', function(){
			$(".car-categorys .car-category").removeClass("active");
			$(this).addClass("active");
			renderCarBrandView();
		});
	}

	/**
	 * 根据车系修改品牌列表
	 * @param category
	 */
	function renderCarBrandView() {
		var id = $(".car-categorys .car-category.active").attr("data-id");
		console.log(id);
		mui.post('wechat/carModel/brands.do',{category : id},function(data){
			$("#car-brands").empty();
			if(data == null || data.length == 0){
				$(".empty-tips").css("display", "block");
				$("#car-brands").css("display", "none");
				return;
			}else{
				$(".empty-tips").css("display", "none");
				$("#car-brands").css("display", "block");
			}
			renderOrder(data);
		});
	}

	function renderOrder(data) {
		var html = $("#boxTpl").render(data);
		$("#car-brands").append(html);
	}
</script>


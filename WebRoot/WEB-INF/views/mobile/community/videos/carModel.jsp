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
	<title>年型选择</title>
	<link href="lib/mui/css/mui.min.css" rel="stylesheet" />
	<link href="lib/mui/css/style.css" rel="stylesheet" />
	<script src="lib/mui/js/mui.min.js"></script>
	<script src="http://res2.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
	<script src="lib/jquery/jquery-3.4.1.js"></script>
	<link rel="stylesheet" href="lib/admin/wechatfonts/style.css">
	<style>
		.mui-table-view-cell>a:not(.mui-btn).mui-active{
			background-color: #3ba6ff;
			color: white;
		}
		.mui-table-view-cell:after{
			left: 0;
		}
		.mui-table-view li a div{
			font-size: 14px;
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
			margin-left: 5px;
			margin-right: 5px;
		}
		.empty-tips{
			display: block;
			margin: calc(50% - 50px) auto;
			width: 180px;
			height: auto;
		}

		.mui-media-body .car-model-name{
			font-size: 14px;
			font-weight: 600;
			margin-right: 10px;
		}
		.mui-media-body .car-model-config{
			font-size: 12px;
			font-weight: normal;
			color: #7b7b7b;
		}
	</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
		<h1 class="mui-title">${name}</h1>
	</header>
	<div class="mui-content" style="background-color: white">
		<c:if test="${empty models}">
			<img class="empty-tips" src="image/no_datas.png"/>
		</c:if>
		<c:if test="${not empty models}">
			<ul class="mui-table-view" style="margin-top: 0">
				<c:forEach items="${models}" var="item">
					<li class="mui-table-view-cell mui-media ">
						<a href="wechat/carVideo/toVideoClass.do?modelId=${item.id}&name=${name}">
							<div class="mui-media-body mui-navigate-right">
								<div class="car-model-name">${item.modelName}</div>
								<div class="car-model-config">${item.engine} - ${item.gear}</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>
</body>
</html>
<script>


</script>


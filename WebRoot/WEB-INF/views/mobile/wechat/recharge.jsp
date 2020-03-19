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
    <script src="lib/mui/js/mui.view.js"></script>
    <script src="lib/jquery/jquery-3.4.1.js"></script>
    <script src="lib/jquery/jsrender.js"></script>

    <style>
		.mui-content{
			background-color: #f9f9f9;
		}
		#meal-categorys .meal-vip-item {
			text-align: center;
			padding: 10px;
		}
		#meal-categorys .meal-vip-item.active .meal-vip-body{
			background-color: #ff7500;
			color: white;
		}
		#meal-categorys .meal-vip-item .meal-vip-body{
			background-color: white;
			border-radius: 5px;
			padding: 15px 5px;
			border: 1px solid #cecece;
			font-size: 14px;
			box-shadow: 0px 0px 10px 2px #a0a0a0;
		}
		#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title{
			display: block;
			font-family: "Helvetica Neue", "Helvetica", "Arial", "sans-serif";
		}

		#meal-categorys .meal-vip-item.active .meal-vip-body .meal-vip-money{
			color: white;
		}
		#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-money{
			color: #6b6b6b;
		}
		.meal-infos-title{
			padding: 10px;
			font-size: 13px;
		}
		.meal-btn-btn{

			color: #fff;
			border: 1px solid #ff7500;
			background-color: #ff7500;
		}
		.meal-btn-block{
			font-size: 16px;
			display: block;
			width: 100%;
			padding: 13px 0;
		}
	</style>
	</head>
	<body>
	 <header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">开通VIP</h1>
		</header>
	
		<div class="mui-content">
			<div class="mui-card-header mui-card-media" style="height:120px; padding:30px 25px;   background-image:url(image/wechat/star.png)">
							<img class="mui-media-object mui-pull-left head-img"  src="image/wechat/60x60.gif">
							<div class="mui-media-object" style="color: white;margin-left: 80px">
								${user.userRealname}
								<p>
									 <c:choose>
										 <c:when test="${"2"}"

									 </c:choose>

								</p>
							</div>
			</div>
			<div class="meal-infos-title"><span>请选择VIP时长</span></div>
			<div id="meal-categorys" class="mui-row">

				<c:forEach items="${communityMeals}" var="communityMeal" varStatus="i">
					<div class="meal-vip-item mui-col-sm-4 mui-col-xs-4 ${i.first ? 'active' : ''}" data-month="${communityMeal.month}">
						<div class="meal-vip-body">
							<span class="meal-vip-title">${communityMeal.title}</span>
							<span class="meal-vip-money">￥${communityMeal.money}</span>
						</div>
					</div>
				</c:forEach>
			</div>

			<div class="mui-content-padded" style="margin-top: 50px">
				<button id='pay' type="button"  class="mui-btn meal-btn-block meal-btn-btn">立即开通</button>
			</div>
	    </div>


	</body>
	<script>
		mui.init();

		mui(document.body).on("tap","#meal-categorys .meal-vip-item",function (e) {
			$("#meal-categorys .meal-vip-item").removeClass("active");
			$(this).addClass("active");
		})

		mui(document.body).on("tap","#pay",function (e) {
			$("#meal-categorys .meal-vip-item").removeClass("active");
			$(this).addClass("active");
		})


	</script>

</html>

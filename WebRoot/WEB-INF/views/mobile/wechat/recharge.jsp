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
			padding: 5px;
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
			font-size: 13px;
			box-shadow: 2px 4px 9px 1px #d4c7c7;
			/*width: 105px;
			height: 80px;*/
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
			margin-top: 10px;
			padding: 10px;
			font-size: 14px;
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
		.mui-media-object .meal-vip{
			margin: 5px -5px;
			border-radius: 20px;
			background-color: #312f2f;
			color: white;
			text-align: center;
			font-size: 12px;
			width: 150px;
		}
		.meal-infos-tip{
			margin-top:30px;
			padding: 10px;
			font-size: 13px;
		}
		.meal-infos-tip  span{
			color: #8f8f94;
		}
		.meal-infos-tip  p{
			color: #000;
		}
		#meal-categorys{
			padding: 0 5px;
		}
		@media (min-width: 320px){
			#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title{
				font-size: 13px;
			}
			#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title::after{
				font-size: 13px;
				content: "";
			}
			#meal-categorys .meal-vip-item .meal-vip-body{
				padding-top: 8px;
				padding-bottom: 8px;
			}
		}

		@media (min-width: 355px){
			#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title{
				font-size: 14px;
			}
			#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title::after{
				font-size: 14px;
				content: "会员";
			}

			#meal-categorys .meal-vip-item .meal-vip-body{
				padding-top: 12px;
				padding-bottom: 12px;
			}
		}
		@media (min-width: 374px){
			#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title{
				font-size: 14px;
			}
			#meal-categorys .meal-vip-item .meal-vip-body .meal-vip-title::after{
				font-size: 14px;
			}
			#meal-categorys .meal-vip-item .meal-vip-body{
				padding-top: 15px;
				padding-bottom: 15px;
			}
		}
	</style>
</head>
<body>
<header class="mui-bar mui-bar-nav">
	<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
	<h1 class="mui-title">开通VIP</h1>
</header>

<div class="mui-content">
	<div class="mui-card-header mui-card-media" style="height:130px; padding:35px 25px;   background-image:url(image/wechat/star.png)">
		<img class="mui-media-object mui-pull-left head-img" style="border-radius: 50%;width: 60px; height: 60px" src="image/wechat/60x60.gif">
		<div class="mui-media-object" style="color: white;margin-left: 80px;padding-top: 5px">
			${user.userRealname}
			<p class = "meal-vip">
				<c:if test="${empty flag}">你还没开通VIP</c:if>
				<c:if test="${not empty flag}">会员到期时间: ${flag}</c:if>
			</p>
		</div>
	</div>
	<div class="meal-infos-title"><span>请选择VIP时长</span></div>
	<div id="meal-categorys" class="mui-row">
		<c:forEach items="${communityMeals}" var="communityMeal" varStatus="i">
			<div class="meal-vip-item mui-col-sm-4 mui-col-xs-4 ${i.first ? 'active' : ''}" data-month="${communityMeal.month}" data-id="${communityMeal.id}" data-money="${communityMeal.money}">
				<div class="meal-vip-body">
					<span class="meal-vip-title">${communityMeal.title}</span>
					<span class="meal-vip-money">￥${communityMeal.money}</span>
				</div>
			</div>


		</c:forEach>
	</div>

	<div class="mui-content-padded" style="margin-top: 80px">
		<button style="display:${empty flag ? block:none}" id='pay' type="button"  class="mui-btn meal-btn-block meal-btn-btn">
			${empty flag ? '立即开通' :'续费'}
		</button>
	</div>

	<div class="meal-infos-tip">
		<p>
			充值说明：
		</p>
		<span>
                 如存在任何疑问可咨询：
                </span>
		<br>
		<span>
                微信：15984421 QQ:1531974646 或者关注"连途"<br>公众号进行咨询；
                </span>
	</div>
</div>

<input type="hidden" id ="orderType" name="orderType" value="${empty flag ? '1' :'2'}"/>
</body>
<script>
	var appId,timeStamp,nonceStr,packagse,signType,paySign;
	mui.init();

	mui(document.body).on("tap","#meal-categorys .meal-vip-item",function (e) {
		$("#meal-categorys .meal-vip-item").removeClass("active");
		$(this).addClass("active");
	})

	mui(document.body).on("tap","#pay",function (e) {
		document.getElementById("pay").setAttribute("disabled", true);
		var param = {
			"mealId" : $("#meal-categorys .meal-vip-item.active").attr("data-id"),
			"month":$("#meal-categorys .meal-vip-item.active").attr("data-month"),
			"payAmount":$("#meal-categorys .meal-vip-item.active").attr("data-money"),
			"orderType":$("#orderType").val(),
			"payType":"1"
		}

		mui.post("wechat/community/pay/orders.do", param , function (data) {

			if (data.retCode == "success"){
				appId = data.retData.appId;
				timeStamp = data.retData.timeStamp;
				nonceStr = data.retData.nonceStr;
				packagse = data.retData.packagse;
				signType = data.retData.signType;
				paySign = data.retData.paySign;
				if (typeof WeixinJSBridge == "undefined") {
					if (document.addEventListener) {
						document.addEventListener('WeixinJSBridgeReady',
								onBridgeReady, false);
					} else if (document.attachEvent) {
						document.attachEvent('WeixinJSBridgeReady',
								onBridgeReady);
						document.attachEvent('onWeixinJSBridgeReady',
								onBridgeReady);
					}
				} else {
					onBridgeReady();
				}
			}else{

				mui.alert("充值失败");
			}
			document.getElementById("pay").removeAttribute("disabled");

		},'json'
	  )

	})
	function onBridgeReady(){
		WeixinJSBridge.invoke( 'getBrandWCPayRequest', {
					"appId":appId,     //公众号名称,由商户传入
					"timeStamp":timeStamp,         //时间戳,自1970年以来的秒数
					"nonceStr":nonceStr, //随机串
					"package":packagse,
					"signType":signType, //微信签名方式：
					"paySign":paySign //微信签名
				},
				function(res){
					if(res.err_msg == "get_brand_wcpay_request:ok" ) {
						console.log('支付成功');
						alert(111);
						//支付成功后跳转的页面
					}else if(res.err_msg == "get_brand_wcpay_request:cancel"){
						alert(222);
						console.log('支付取消');
					}else if(res.err_msg == "get_brand_wcpay_request:fail"){
						console.log('支付失败');
						alert(333);
						WeixinJSBridge.call('closeWindow');
					} //使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回ok,但并不保证它绝对可靠。
				});
	}

</script>

</html>

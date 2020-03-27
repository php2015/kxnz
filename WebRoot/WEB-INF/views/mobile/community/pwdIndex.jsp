<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<title>忘记密码</title>
		<link href="lib/mui/css/mui.min.css" rel="stylesheet" />
		<link href="lib/mui/css/style.css" rel="stylesheet" />
		<script src="lib/mui/js/mui.min.js"></script>
		<script src="lib/mui/js/mui.enterfocus.js"></script>
		<script src="lib/mui/js/app.js"></script>
		<script src="lib/jquery/jquery-3.4.1.js"></script>
		<script src="lib/jquery/jquery.autocompleter.js"></script>
		<script src="lib/jquery/jquery-ui.js"></script>
		
	</head>
	<style>
		.mui-content-padded {
			margin-top: 25px;
		}

		.mui-btn {
			padding: 10px;
		}
		.link-area {
			display: block;
			margin-top: 25px;
			text-align: center;
		}

		.spliter {
			color: #bbb;
			padding: 0px 8px;
		}
	</style>

	<body>
		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">忘记密码</h1>
		</header>
		<div class="mui-content">
			<form id='forget-form' class="mui-input-group" style="margin-top: 50px	" >
				<div class="mui-input-row">
					<label>手机号</label>
					<input id="userName" name='userName' type="text" class="mui-input-clear mui-input" placeholder="请输入手机号">
				</div>
				<div class="mui-input-row">
					<label>用户名</label>
					<input id='userRealname' name='userRealname' type="text" class="mui-input-clear mui-input" placeholder="请输入注册时的用户名">
				</div>
				<div class="mui-input-row">
					<label>新密码</label>
					<input id='pwd2' name='pwd2' type="password" class="mui-input-password" placeholder="">
				</div>
				<div class="mui-input-row">
					<label>确认密码</label>
					<input id='pwd3' name='pwd3' type="password" class="mui-input-password" placeholder="">
				</div>
			</form>
			<div class="mui-content-padded" style="margin-top: 50px">
				<button id='submit' type="button" class="mui-btn mui-btn-block mui-btn-primary"
						data-loading-icon="mui-spinner mui-spinner-custom"
						data-loading-text="请稍后...">提交</button>
			</div>
		</div>
		<script>
			mui('body').on('tap','#submit',function(){
				var me = this;
				mui(me).button('loading');
				var param = {userName: $("#userName").val().trim(),userRealname: $("#userRealname").val().trim(),pwd2: $("#pwd2").val().trim(),pwd3: $("#pwd3").val().trim(),};
				if(!(/^1[3456789]\d{9}$/.test(param.userName))){
					mui.alert("手机号码有误，请重填");
					mui(me).button('reset');
					return false;
				}

				if(param.userRealname == null || param.userRealname.length == 0){
					mui.alert("用户名不能为空!");
					mui(me).button('reset');
					return false;
				}

				if(!param.pwd2 || param.pwd2.length == 0){
					mui.alert("密码不能为空");
					mui(me).button('reset');
					return false;
				}else if(!(/^[\w_]{1,16}$/.test(param.pwd2))){
					mui.alert("密码只能由字母、数字、下划线组成, 且长度不能超过16位");
					mui(me).button('reset');
					return false;
				}
				if(param.pwd2 !== param.pwd3){
					mui.alert("确认密码与新密码不一致!");
					mui(me).button('reset');
					return false;
				}

				mui.ajax('wechat/community/modifyPwd.do',{
					data: JSON.stringify(param),
					dataType:'json',
					type:'post',//HTTP请求类型
					timeout:10000,//超时时间设置为10秒；
					headers:{'Content-Type':'application/json'},
					success:function(data){
						mui.toast(data.retMsg);
						if(data != null && data.retCode == 'success'){
                            mui.openWindow({
                                url: 'wechat/community.do'
                            });
                            // 关闭当前页
                            if (typeof window.listPage != 'undefined') {
                                mui.fire(window.listPage, 'reloadData', null);
                            }
                            if (mui.os.plus) {
                                mui.plusReady(function () {
                                    var ws = plus.webview.currentWebview();
                                    plus.webview.close(ws);
                                });
                            }
                            mui.back();
                        }else{
                            mui(me).button('reset');
                        }
					},
					error:function(xhr,type,errorThrown){
						mui(me).button('reset');
					}
				})
			});

		</script>
	</body>
</html>
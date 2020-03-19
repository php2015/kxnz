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
<html class="ui-page-mine">
<base href="<%=basePath%>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>连途社区首页</title>
    <link href="lib/mui/css/mui.min.css" rel="stylesheet" />
    <link href="lib/mui/css/mui-icons-extra.css" rel="stylesheet" />
    <link href="lib/mui/css/app.css" rel="stylesheet" />
    <script src="lib/mui/js/mui.min.js"></script>
    <script src="lib/jquery/jquery-3.4.1.js"></script>
    <script src="lib/jquery/jsrender.js"></script>
    <style>
    </style>
</head>
<body>
<div id="consultation-page">
    <div id="slider" class="mui-slider"
         style="height: 160px; ${empty banners ? 'display:none':''}">
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
    <div class="video-type">
        <ul id="video-type-ul" class="mui-table-view mui-grid-view mui-grid-9" style="padding:10px;">

        </ul>
    </div>
</div>
</body>

<script>
    mui.init();

    mui.ready(function () {
        readBanner();
    });

    function readBanner(){
    }
</script>
</html>
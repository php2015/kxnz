<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title>视频列表</title>
    <link href="lib/mui/css/mui.min.css" rel="stylesheet"/>
    <link href="lib/mui/css/mui-icons-extra.css" rel="stylesheet"/>
    <link href="lib/mui/css/style.css" rel="stylesheet"/>
    <script src="lib/mui/js/mui.min.js"></script>
    <script src="lib/jquery/jquery-3.4.1.js"></script>
    <style>
        .mui-table-view-cell > a:not(.mui-btn).mui-active {
            background-color: #3ba6ff;
            color: white;
        }

        .mui-table-view-cell:after {
            left: 0;
        }

        .empty-tips {
            display: block;
            margin: calc(50% - 50px) auto;
            width: 180px;
            height: auto;
        }

        .mui-table-view-cell {
            padding-left: 10px;
            padding-right: 10px;
        }

        .mui-table-view li a div {
            font-size: 14px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            margin-left: 5px;
            margin-right: 5px;
        }

        .float-left {
            float: left;
        }

        .float-right {
            float: right;
        }

        .clear-float {
            clear: both;
        }

        .mui-media-body {
            height: 85px;
            padding: 5px 0;
        }

        .car-video-image {
            width: 120px;
            height: 100%;
            float: left;
            border: 1px solid #bdbdbd;
            border-radius: 2px;
        }

        .car-video-body {
            height: 100%;
            width: calc(100% - 130px);
            margin: 0 5px;
        }

        .car-video-body .car-video-title {
            font-weight: bold;
            font-size: 14px;
            height: 25px;
            line-height: 25px;
        }

        .car-video-body .car-video-describe {
            font-weight: normal;
            font-size: 12px;
            color: #bababa;
            height: 25px;
            line-height: 25px;
        }

        .car-video-body .car-video-other div {
            font-weight: normal;
            font-size: 11px;
            color: #9e9e9e;
            height: 25px;
            line-height: 35px;
        }

        .car-video-body .car-video-other .mui-icon, .car-video-body .car-video-other .mui-icon-extra {
            font-size: 13px;
            margin-right: 2px;
        }

        .member-0 {

        }

        .member-1 {

        }

        .member-2 {

        }

        .member-0 .car-video-title:before {
            content: "免费";
            color: white;
            background-color: #e1e1e1;
            padding: 3px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: normal;
            margin-right: 4px;
        }

        .member-1 .car-video-title:before {
            content: "VIP";
            color: white;
            background-color: #ffbf48;
            padding: 3px 6px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: normal;
            margin-right: 4px;
        }

        .member-2 .car-video-title:before {
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
</head>
<body>
<script type="text/javascript" charset="utf-8">
    mui.init();
</script>
<header class="mui-bar mui-bar-nav">
    <a href="javascript:void(0)" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">${title}</h1>
</header>
<div class="mui-content" style="background-color: white">
    <c:if test="${empty videoList}">
        <img class="empty-tips" src="image/no_datas.png"/>
    </c:if>
    <c:if test="${not empty videoList}">
        <ul class="mui-table-view" style="margin-top: 0">
            <c:forEach items="${videoList}" var="item">
                <li class="mui-table-view-cell mui-media member-${item.member}" data-id="${item.id}" data-member="${item.member}">
                    <a>
                        <div class="mui-media-body mui-navigate-right">
                            <img class="car-video-image float-left" src="mobile/shop/getImage.do?path=${item.coverUrl}"
                                 onerror="this.onerror='';this.src='image/no_picture.jpg'"/>
                            <div class="car-video-body float-right">
                                <div class="car-video-title">${item.title}</div>
                                <div class="car-video-describe">${item.describe}</div>
                                <div class="car-video-other">
                                    <div class="car-video-browse float-left">
                                        <span class="mui-icon mui-icon-navigate"></span>${item.browseNum}</div>
                                    <div class="car-video-collect float-left">
                                        <span class="mui-icon-extra mui-icon-extra-heart"></span>${item.collectNum}
                                    </div>
                                    <div class="car-video-time float-right"><fmt:formatDate type="date"
                                                                                            value="${item.createTime}"/></div>
                                </div>
                            </div>
                            <div class="clear-float"></div>
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

    mui('body').on('tap', '.mui-table-view .mui-table-view-cell', function () {
        var videoId = $(this).attr("data-id");
        var member = $(this).attr("data-member");
        mui.post("wechat/carVideo/checkUser.do", {videoId: videoId, member: member}, function (res) {
            if (res != null && res.code == 200) {
                window.top.location.href = res.url;
            } else {
                mui.confirm(res.msg, "提示", "是", function () {

                });
            }
        })
    });
</script>


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
    <script src="lib/mui/js/mui.pullToRefresh.js"></script>
    <script src="lib/mui/js/mui.pullToRefresh.material.js"></script>
    <style>

        .float-left {
            float: left;
        }

        .float-right {
            float: right;
        }

        .clear-float {
            clear: both;
        }
        #consultation-page{
            height: 100%;
        }
        #consultation-page .video-type-image{
            max-height: 50px;
            width: auto;
        }

        #consultation-page .video-type-text{
            font-size: 12px;
            margin-top: 3px;
        }
        #consultation-page .video-list .mui-control-content {
            background-color: white;
            min-height: 215px;
        }
        #consultation-page .video-list .mui-control-content .mui-loading {
            margin-top: 50px;
        }
        @media (min-width: 320px){
            #consultation-page .video-type .mui-table-view-cell {
                width: 25%;
            }
            #consultation-page .video-type .mui-table-view-cell .video-type-image{
                max-height:45px
            }
        }
        @media (min-width: 370px){
            #consultation-page .video-type .mui-table-view-cell {
                width: 20%;
            }
            #consultation-page .video-type .mui-table-view-cell .video-type-image{
                max-height:50px
            }
        }

        #consultation-page .video-list .mui-slider.mui-fullscreen{
            height: 100%;
            position: relative;
        }
        #consultation-page .video-list .mui-slider-group{
            height: calc(100% - 40px);
        }


        #consultation-page .video-list .mui-table-view-cell {
            padding-left: 10px;
            padding-right: 10px;
        }

        #consultation-page .video-list .mui-media-body {
            height: 85px;
            padding: 5px 0;
        }

        #consultation-page .video-list .car-video-image {
            width: 120px;
            height: 100%;
            float: left;
            border: 1px solid #bdbdbd;
            border-radius: 2px;
        }

        #consultation-page .video-list .car-video-body {
            height: 100%;
            width: calc(100% - 130px);
            margin: 0 5px;
        }

        #consultation-page .video-list .car-video-body .car-video-title {
            font-weight: bold;
            font-size: 14px;
            height: 25px;
            line-height: 25px;
        }

        #consultation-page .video-list .car-video-body .car-video-describe {
            font-weight: normal;
            font-size: 12px;
            color: #bababa;
            height: 25px;
            line-height: 25px;
        }

        #consultation-page .video-list .car-video-body .car-video-other div {
            font-weight: normal;
            font-size: 11px;
            color: #9e9e9e;
            height: 25px;
            margin-right: 5px;
            line-height: 35px;
        }

        #consultation-page .video-list .car-video-body .car-video-other .mui-icon {
            font-size: 13px;
            margin-right: 2px;
        }
        #consultation-page .video-list .member-0 .car-video-title:before {
            content: "免费";
            color: white;
            background-color: #a2a2a2;
            padding: 3px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: normal;
            margin-right: 4px;
        }

        #consultation-page .video-list .member-1 .car-video-title:before {
            content: "VIP";
            color: white;
            background-color: #ffbf48;
            padding: 3px 6px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: normal;
            margin-right: 4px;
        }

        #consultation-page .video-list .member-2 .car-video-title:before {
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
    <style>
        .mui-pull-top-tips {
            position: absolute;
            top: -20px;
            left: 50%;
            margin-left: -25px;
            width: 40px;
            height: 40px;
            border-radius: 100%;
            z-index: 1;
        }
        .mui-bar~.mui-pull-top-tips {
            top: 24px;
        }
        .mui-pull-top-wrapper {
            width: 42px;
            height: 42px;
            display: block;
            text-align: center;
            background-color: #efeff4;
            border: 1px solid #ddd;
            border-radius: 25px;
            background-clip: padding-box;
            box-shadow: 0 4px 10px #bbb;
            overflow: hidden;
        }
        .mui-pull-top-tips.mui-transitioning {
            -webkit-transition-duration: 200ms;
            transition-duration: 200ms;
        }
        .mui-pull-top-tips .mui-pull-loading {
            /*-webkit-backface-visibility: hidden;
            -webkit-transition-duration: 400ms;
            transition-duration: 400ms;*/

            margin: 0;
        }
        .mui-pull-top-wrapper .mui-icon,
        .mui-pull-top-wrapper .mui-spinner {
            margin-top: 7px;
        }
        .mui-pull-top-wrapper .mui-icon.mui-reverse {
            /*-webkit-transform: rotate(180deg) translateZ(0);*/
        }
        .mui-pull-bottom-tips {
            text-align: center;
            background-color: #efeff4;
            font-size: 15px;
            line-height: 40px;
            color: #777;
        }
        .mui-pull-top-canvas {
            overflow: hidden;
            background-color: #fafafa;
            border-radius: 40px;
            box-shadow: 0 4px 10px #bbb;
            width: 40px;
            height: 40px;
            margin: 0 auto;
        }
        .mui-pull-top-canvas canvas {
            width: 40px;
        }
        .mui-slider-indicator.mui-segmented-control {
            background-color: #efeff4;
        }
    </style>
</head>
<body>
<div id="consultation-page">
    <div id="banner-slider" class="mui-slider"
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
    <%--视频类型--%>
    <div class="video-type">
        <ul id="video-type-ul" class="mui-table-view mui-grid-view mui-row" style="padding:0 10px 10px 10px;">
            <c:forEach items="${videoClass}" var="item" varStatus="i">
                <li class="mui-table-view-cell">
                    <a href="wechat/carVideo/toVideoList.do?classId=${item.id}">
                        <img class="mui-media-object video-type-image" src="${item.imgUrl}" onerror="this.onerror='';this.src='image/no_picture.jpg'">
                        <div class="mui-media-body video-type-text">${item.name}</div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <%--视频列表--%>
    <div class="video-list">
        <%--选项卡--%>
            <div id="video-list-slider" class="mui-slider mui-fullscreen">
                <div id="sliderSegmentedControl" class="mui-slider-indicator mui-segmented-control mui-segmented-control-inverted">
                    <a class="mui-control-item active" data-type="Hot" href="#itemVideoListHot">热门</a>
                    <a class="mui-control-item" data-type="New" href="#itemVideoListNew">最新</a>
                </div>
                <div id="sliderProgressBar" class="mui-slider-progress-bar mui-col-xs-6"></div>
                <div class="mui-slider-group">
                    <div id="itemVideoListHot" data-type="Hot" class="mui-slider-item mui-control-content mui-active">
                        <div class="mui-scroll-wrapper">
                            <div class="mui-scroll">
                                <ul class="mui-table-view"></ul>
                            </div>
                        </div>
                    </div>
                    <div id="itemVideoListNew" data-type="New" class="mui-slider-item mui-control-content">
                        <div class="mui-scroll-wrapper">
                            <div class="mui-scroll">
                                <ul class="mui-table-view"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</div>
<script type="text/x-jsrender" id="consultationVideoListBoxTpl">
{{for}}
	<li class="mui-table-view-cell mui-media member-{{:member}}" data-id="{{:id}}" data-member="{{:member}}">
		<a>
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
</body>
<script>

    // 根据页面大小, 重新设置视频列表高度
    var videoListHeight = $("#consultation-page").height() - $("#consultation-page #banner-slider").height() - $("#consultation-page .video-type").height() - 2;
    $("#consultation-page .video-list").css("height", videoListHeight +"px");


    function videoListBoxRender(data) {
        return $("#consultationVideoListBoxTpl").render(data);
    }
    (function($) {
        var queryLimit = 4;
        //阻尼系数
        var deceleration = mui.os.ios?0.003:0.003;
        $('#consultation-page .video-list .mui-scroll-wrapper').scroll({
            bounce: false,
            indicators: true, //是否显示滚动条
            deceleration:deceleration
        });

        var createHtml = function(element, index, limit, down) {
            var page = down ? 1 : (element.getAttribute("data-page") || 0) * 1 + 1;
            element.setAttribute("data-page", page);
            var type = element.getAttribute("data-type");
            var data = [];
            mui.ajax('wechat/community/video/indexList.do',{
                async: false,
                data: {type: type, page: page, limit: limit},
                type: 'post',
                dataType: 'json',
                timeout: 10000,
                success: function(res){data = res;},
                error: function(xhr, type, errorThrown){console.log(type);}
            });
            //console.log("index: "+index, "limit: "+limit, "type: "+type, "page: "+page);
            return videoListBoxRender(data);
        };
        //循环初始化所有下拉刷新，上拉加载。
        $.ready(function() {
            $.each(document.querySelectorAll('#consultation-page .video-list .mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
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

    mui.ready(function () {

    });


</script>
</html>
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
    <style>


        #consultation-page{
            height: 100%;
        }

    </style>
</head>
<body>
<div id="consultation-page">

</div>
</body>
<script>
    // 根据页面大小, 重新设置视频列表高度
    var videoListHeight = $("#consultation-page").innerHeight() - $("#consultation-page #banner-slider").outerHeight() - $("#consultation-page .video-type").outerHeight() - 2;
    $("#consultation-page .video-list").css("height", videoListHeight +"px");


    function videoListBoxRender(data) {
        return $("#consultationVideoListBoxTpl").render(data);
    }
    (function($) {
        var queryLimit = 20;
        //阻尼系数
        var deceleration = mui.os.ios?0.003:0.003;
        /*$('#consultation-page .video-list .mui-scroll-wrapper').scroll({
            bounce: false,
            indicators: true, //是否显示滚动条
            deceleration:deceleration
        });*/


        //循环初始化所有下拉刷新，上拉加载。
        $.ready(function() {
            /*$.each(document.querySelectorAll('#consultation-page .video-list .mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
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
            });*/
        });

    })(mui);
    mui('body').on('tap', '#consultation-page .video-list .mui-slider-group .mui-table-view-cell', function () {
        console.log('tap')
        var videoId = this.getAttribute("data-id");
        var member = this.getAttribute("data-member");
        /*mui.post("wechat/community/video/checkUser.do", {videoId: videoId, member: member}, function (res) {
            if (res != null && res.code == 200) {
                mui.openWindow({
                    url: res.url,
                });
            } else {
                mui.confirm(res.msg, "提示", "是", function () {

                });
            }
        })*/
    }).on('tap', '#consultation-page .video-type .mui-table-view-cell',function () {
        var classId = this.getAttribute("data-class-id");
        var title = this.getAttribute("data-title");
        mui.openWindow({
            url: 'wechat/community/video/typeVideoList.do?classId='+classId+'&title='+title
        })
    });


    mui.init({
        pullRefresh : {
            container:"#consultation-page .video-list #itemVideoListHot .mui-scroll-wrapper",//下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等
            down : {
                style:'circle',//必选，下拉刷新样式，目前支持原生5+ ‘circle’ 样式
                color:'#2BD009', //可选，默认“#2BD009” 下拉刷新控件颜色
                height:'30px',//可选,默认50px.下拉刷新控件的高度,
                range:'40px', //可选 默认100px,控件可下拉拖拽的范围
                offset:'0px', //可选 默认0px,下拉刷新控件的起始位置
                auto: true,//可选,默认false.首次加载自动上拉刷新一次
                callback :function () {
                    var self = this;
                    setTimeout(function() {
                        var ul = self.element.querySelector('.mui-table-view');
                        ul.innerHTML = createHtml(self.element.parentElement, 0, 5, true);
                    }, 1000);
                } //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
            },
            up : {
                height:50,//可选.默认50.触发上拉加载拖动距离
                //auto:true,//可选,默认false.自动上拉加载一次
                contentrefresh : "正在加载...",//可选，正在加载状态时，上拉加载控件上显示的标题内容
                contentnomore:'没有更多数据了',//可选，请求完毕若没有更多数据时显示的提醒内容；
                callback :function () {
                    var ul = this.element.querySelector('.mui-table-view');
                    var html = createHtml(this.element.parentElement, 0, 10);
                    ul.innerHTML += html;
                    this.endPullUpToRefresh(html == null || html.length == 0);
                }
            }
        }
    });
</script>
</html>
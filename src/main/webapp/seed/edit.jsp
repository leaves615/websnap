<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="w" uri="http://www.zjhtc.com/tags/pager"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://zjht.com/jsp/tag/form" %>
<!doctype html>
<html lang="zh">
<head>
	<title>管理平台-网站管理</title>
    <jsp:include page="/include/commons-include.jsp"/>
    <script src="${ctx}/assets/cron/cron.js" type="text/javascript"></script>
    <script src="${ctx}/assets/cron/jquery.easyui.min.js" type="text/javascript"></script>
</head>
<body class="no-skin">
		<!--顶部导航栏-->
	<jsp:include page="/include/commons-navbar.jsp"/>
	<!-- 主框架 -->
	<div class="main-container" id="main-container">
    <script type="text/javascript">
        try{ace.settings.check('main-container' , 'fixed')}catch(e){}
    </script>

	<!-- 左侧导航 -->
    <jsp:include page="/include/commons-sidebar.jsp"/>
    <!-- 左侧导航结束 -->

    <!--右侧主内容 -->
    <div class="main-content">

        <div class="main-content-inner">
     <!-- 主内容顶部导航 -->
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}/">Home</a>
                    </li>
                    <li>爬虫管理</li>
                    <li>网站管理</li>
                    <li class="active">网站修改</li>
                </ul><!-- /.breadcrumb -->
            </div><!-- 主内容顶部导航结束 -->


 <div class="page-content">
      <div class="row">
          <div class="col-xs-12">
              <form class="form-horizontal" action="${ctx}/seed/${seed.id}/update" method="post" id="form">
                  <h3 class="lighter block green">添加网站</h3>
                  <input type="hidden" name="id" value="${seed.id}">
                  <form:input label="网站名称：" name="name" value="${seed.name}"/>
                  <form:input label="URL：" name="url" extendAttribute="placeholder='http://'" value="${seed.url}"/>
                  <div class="form-group">
                      <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="cron">计划：</label>
                      <div class="col-xs-12 col-sm-9">
                          <div class="input-group col-sm-5">
                              <input id="cron" name="cron" type="text" class="col-xs-12 col-sm-12" value="${seed.cron}" data-toggle="modal" data-target="#cron-modal" readonly>
                              <a href="#" class="input-group-addon" data-toggle="modal" data-target="#cron-modal">设置</a>
                          </div>
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="control-label col-xs-12 col-sm-3 no-padding-right"></label>
                      <div class="col-xs-12 col-sm-9">
                          <div class="bg-info text-left">
                              计划域的格式是字符串，实际由实际上是由七子表达式，描述个别细节的时间表<br>
                              这些子表达式是分开的空白，代表：<br>
                              1.        Seconds<br>
                              2.        Minutes<br>
                              3.        Hours<br>
                              4.        Day-of-Month<br>
                              5.        Month<br>
                              6.        Day-of-Week<br>
                              7.        Year (可选字段)<br>
                              <a href="http://www.cnblogs.com/sunjie9606/archive/2012/03/15/2397626.html" target="_blank">详细使用指南</a>
                          </div>
                      </div>
                  </div>
                  <form:input label="并发数：" name="numberOfCrawler" inputType="number" className="input-mini" value="${seed.numberOfCrawler}"/>
                  <form:input label="字符编码" name="charset" value="${seed.charset}"/>
                  <%
                      Map<String, String> statusMap = new HashMap<String, String>();
                      statusMap.put("false", "禁用");
                      statusMap.put("true", "启用");
                      request.setAttribute("statusMap", statusMap);
                  %>
                  <form:select label="状态：" name="status" map="${statusMap}" value="${seed.status}"/>
                  <div class="form-group">
                      <label class="control-label col-xs-12 col-sm-3 no-padding-right"></label>
                      <div class="col-xs-12 col-sm-9">
                          <div class="btn-group">
                              <button type="submit" class="btn btn-primary btn-small">提交</button>
                              <button type="reset" class="btn btn-light btn-small">重置</button>
                          </div>
                      </div>
                  </div>
              </form>
          </div>
	  </div>

	</div>
	</div>
	</div><!--右侧主内容结束 -->
</div>
        <div id="cron-modal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">设置计划</h4>
                    </div>
                    <div class="modal-body center">
                        <form id="set-cron-form">
                            <div class="tabbable">
                                <ul class="nav nav-tabs" id="myTab">
                                    <li class="active">
                                        <a data-toggle="tab" href="#cron-set-second" aria-expanded="true">秒</a>
                                    </li>

                                    <li class="">
                                        <a data-toggle="tab" href="#cron-set-mintue" aria-expanded="false">分钟</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" href="#cron-set-hour" aria-expanded="false">小时</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" href="#cron-set-day" aria-expanded="false">日</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" href="#cron-set-month" aria-expanded="false">月</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" href="#cron-set-week" aria-expanded="false">周</a>
                                    </li>
                                    <li class="">
                                        <a data-toggle="tab" href="#cron-set-year" aria-expanded="false">年</a>
                                    </li>
                                </ul>

                                <div class="tab-content">

                                    <div id="cron-set-second" class="tab-pane fade active in">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="second" onclick="everyTime(this)">
                                                每秒 允许的通配符[, - * /]</div>
                                            <div class="line">
                                                <input type="radio" name="second" onclick="cycle(this)">
                                                周期从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:58" value="1" id="secondStart_0"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:2,max:59" value="2" id="secondEnd_0"><input type="hidden" value="2"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                秒</div>
                                            <div class="line">
                                                <input type="radio" name="second" onclick="startOn(this)">
                                                从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:0,max:59" value="0" id="secondStart_1"><input type="hidden" value="0"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                秒开始,每
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:59" value="1" id="secondEnd_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                秒执行一次</div>
                                            <div class="line">
                                                <input type="radio" name="second" id="sencond_appoint">
                                                指定</div>
                                            <div class="imp secondList">
                                                <input type="checkbox" value="1">01
                                                <input type="checkbox" value="2">02
                                                <input type="checkbox" value="3">03
                                                <input type="checkbox" value="4">04
                                                <input type="checkbox" value="5">05
                                                <input type="checkbox" value="6">06
                                                <input type="checkbox" value="7">07
                                                <input type="checkbox" value="8">08
                                                <input type="checkbox" value="9">09
                                                <input type="checkbox" value="10">10</div>
                                            <div class="imp secondList">
                                                <input type="checkbox" value="11">11
                                                <input type="checkbox" value="12">12
                                                <input type="checkbox" value="13">13
                                                <input type="checkbox" value="14">14
                                                <input type="checkbox" value="15">15
                                                <input type="checkbox" value="16">16
                                                <input type="checkbox" value="17">17
                                                <input type="checkbox" value="18">18
                                                <input type="checkbox" value="19">19
                                                <input type="checkbox" value="20">20</div>
                                            <div class="imp secondList">
                                                <input type="checkbox" value="21">21
                                                <input type="checkbox" value="22">22
                                                <input type="checkbox" value="23">23
                                                <input type="checkbox" value="24">24
                                                <input type="checkbox" value="25">25
                                                <input type="checkbox" value="26">26
                                                <input type="checkbox" value="27">27
                                                <input type="checkbox" value="28">28
                                                <input type="checkbox" value="29">29
                                                <input type="checkbox" value="30">30</div>
                                            <div class="imp secondList">
                                                <input type="checkbox" value="31">31
                                                <input type="checkbox" value="32">32
                                                <input type="checkbox" value="33">33
                                                <input type="checkbox" value="34">34
                                                <input type="checkbox" value="35">35
                                                <input type="checkbox" value="36">36
                                                <input type="checkbox" value="37">37
                                                <input type="checkbox" value="38">38
                                                <input type="checkbox" value="39">39
                                                <input type="checkbox" value="40">40</div>
                                            <div class="imp secondList">
                                                <input type="checkbox" value="41">41
                                                <input type="checkbox" value="42">42
                                                <input type="checkbox" value="43">43
                                                <input type="checkbox" value="44">44
                                                <input type="checkbox" value="45">45
                                                <input type="checkbox" value="46">46
                                                <input type="checkbox" value="47">47
                                                <input type="checkbox" value="48">48
                                                <input type="checkbox" value="49">49
                                                <input type="checkbox" value="50">50</div>
                                            <div class="imp secondList">
                                                <input type="checkbox" value="51">51
                                                <input type="checkbox" value="52">52
                                                <input type="checkbox" value="53">53
                                                <input type="checkbox" value="54">54
                                                <input type="checkbox" value="55">55
                                                <input type="checkbox" value="56">56
                                                <input type="checkbox" value="57">57
                                                <input type="checkbox" value="58">58
                                                <input type="checkbox" value="59">59
                                            </div>
                                        </div>
                                    </div>

                                    <div id="cron-set-mintue" class="tab-pane fade">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="min" onclick="everyTime(this)">
                                                分钟 允许的通配符[, - * /]</div>
                                            <div class="line">
                                                <input type="radio" name="min" onclick="cycle(this)">
                                                周期从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:58" value="1" id="minStart_0"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:2,max:59" value="2" id="minEnd_0"><input type="hidden" value="2"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                分钟</div>
                                            <div class="line">
                                                <input type="radio" name="min" onclick="startOn(this)">
                                                从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:0,max:59" value="0" id="minStart_1"><input type="hidden" value="0"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                分钟开始,每
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:59" value="1" id="minEnd_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                分钟执行一次</div>
                                            <div class="line">
                                                <input type="radio" name="min" id="min_appoint">
                                                指定</div>
                                            <div class="imp minList">
                                                <input type="checkbox" value="1">01
                                                <input type="checkbox" value="2">02
                                                <input type="checkbox" value="3">03
                                                <input type="checkbox" value="4">04
                                                <input type="checkbox" value="5">05
                                                <input type="checkbox" value="6">06
                                                <input type="checkbox" value="7">07
                                                <input type="checkbox" value="8">08
                                                <input type="checkbox" value="9">09
                                                <input type="checkbox" value="10">10</div>
                                            <div class="imp minList">
                                                <input type="checkbox" value="11">11
                                                <input type="checkbox" value="12">12
                                                <input type="checkbox" value="13">13
                                                <input type="checkbox" value="14">14
                                                <input type="checkbox" value="15">15
                                                <input type="checkbox" value="16">16
                                                <input type="checkbox" value="17">17
                                                <input type="checkbox" value="18">18
                                                <input type="checkbox" value="19">19
                                                <input type="checkbox" value="20">20</div>
                                            <div class="imp minList">
                                                <input type="checkbox" value="21">21
                                                <input type="checkbox" value="22">22
                                                <input type="checkbox" value="23">23
                                                <input type="checkbox" value="24">24
                                                <input type="checkbox" value="25">25
                                                <input type="checkbox" value="26">26
                                                <input type="checkbox" value="27">27
                                                <input type="checkbox" value="28">28
                                                <input type="checkbox" value="29">29
                                                <input type="checkbox" value="30">30</div>
                                            <div class="imp minList">
                                                <input type="checkbox" value="31">31
                                                <input type="checkbox" value="32">32
                                                <input type="checkbox" value="33">33
                                                <input type="checkbox" value="34">34
                                                <input type="checkbox" value="35">35
                                                <input type="checkbox" value="36">36
                                                <input type="checkbox" value="37">37
                                                <input type="checkbox" value="38">38
                                                <input type="checkbox" value="39">39
                                                <input type="checkbox" value="40">40</div>
                                            <div class="imp minList">
                                                <input type="checkbox" value="41">41
                                                <input type="checkbox" value="42">42
                                                <input type="checkbox" value="43">43
                                                <input type="checkbox" value="44">44
                                                <input type="checkbox" value="45">45
                                                <input type="checkbox" value="46">46
                                                <input type="checkbox" value="47">47
                                                <input type="checkbox" value="48">48
                                                <input type="checkbox" value="49">49
                                                <input type="checkbox" value="50">50</div>
                                            <div class="imp minList">
                                                <input type="checkbox" value="51">51
                                                <input type="checkbox" value="52">52
                                                <input type="checkbox" value="53">53
                                                <input type="checkbox" value="54">54
                                                <input type="checkbox" value="55">55
                                                <input type="checkbox" value="56">56
                                                <input type="checkbox" value="57">57
                                                <input type="checkbox" value="58">58
                                                <input type="checkbox" value="59">59
                                            </div>
                                        </div>
                                    </div>

                                    <div id="cron-set-hour" class="tab-pane fade">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="hour" onclick="everyTime(this)">
                                                小时 允许的通配符[, - * /]</div>
                                            <div class="line">
                                                <input type="radio" name="hour" onclick="cycle(this)">
                                                周期从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:0,max:23" value="0" id="hourStart_0"><input type="hidden" value="0"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:2,max:23" value="2" id="hourEnd_1"><input type="hidden" value="2"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                小时</div>
                                            <div class="line">
                                                <input type="radio" name="hour" onclick="startOn(this)">
                                                从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:0,max:23" value="0" id="hourStart_1"><input type="hidden" value="0"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                小时开始,每
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:23" value="1" id="hourEnd_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                小时执行一次</div>
                                            <div class="line">
                                                <input type="radio" name="hour" id="hour_appoint">
                                                指定</div>
                                            <div class="imp hourList">
                                                AM:
                                                <input type="checkbox" value="0">00
                                                <input type="checkbox" value="1">01
                                                <input type="checkbox" value="2">02
                                                <input type="checkbox" value="3">03
                                                <input type="checkbox" value="4">04
                                                <input type="checkbox" value="5">05
                                                <input type="checkbox" value="6">06
                                                <input type="checkbox" value="7">07
                                                <input type="checkbox" value="8">08
                                                <input type="checkbox" value="9">09
                                                <input type="checkbox" value="10">10
                                                <input type="checkbox" value="11">11
                                            </div>
                                            <div class="imp hourList">
                                                PM:
                                                <input type="checkbox" value="12">12
                                                <input type="checkbox" value="13">13
                                                <input type="checkbox" value="14">14
                                                <input type="checkbox" value="15">15
                                                <input type="checkbox" value="16">16
                                                <input type="checkbox" value="17">17
                                                <input type="checkbox" value="18">18
                                                <input type="checkbox" value="19">19
                                                <input type="checkbox" value="20">20
                                                <input type="checkbox" value="21">21
                                                <input type="checkbox" value="22">22
                                                <input type="checkbox" value="23">23
                                            </div>
                                        </div>
                                    </div>

                                    <div id="cron-set-day" class="tab-pane fade">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="day" onclick="everyTime(this)">
                                                日 允许的通配符[, - * / L W]</div>
                                            <div class="line">
                                                <input type="radio" name="day" onclick="unAppoint(this)">
                                                不指定</div>
                                            <div class="line">
                                                <input type="radio" name="day" onclick="cycle(this)">
                                                周期从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:31" value="1" id="dayStart_0"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:2,max:31" value="2" id="dayEnd_0"><input type="hidden" value="2"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                日</div>
                                            <div class="line">
                                                <input type="radio" name="day" onclick="startOn(this)">
                                                从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:31" value="1" id="dayStart_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                日开始,每
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:31" value="1" id="dayEnd_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                天执行一次</div>
                                            <div class="line">
                                                <input type="radio" name="day" onclick="workDay(this)">
                                                每月
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:31" value="1" id="dayStart_2"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                号最近的那个工作日</div>
                                            <div class="line">
                                                <input type="radio" name="day" onclick="lastDay(this)">
                                                本月最后一天</div>
                                            <div class="line">
                                                <input type="radio" name="day" id="day_appoint">
                                                指定</div>
                                            <div class="imp dayList">
                                                <input type="checkbox" value="1">1
                                                <input type="checkbox" value="2">2
                                                <input type="checkbox" value="3">3
                                                <input type="checkbox" value="4">4
                                                <input type="checkbox" value="5">5
                                                <input type="checkbox" value="6">6
                                                <input type="checkbox" value="7">7
                                                <input type="checkbox" value="8">8
                                                <input type="checkbox" value="9">9
                                                <input type="checkbox" value="10">10
                                                <input type="checkbox" value="11">11
                                                <input type="checkbox" value="12">12
                                                <input type="checkbox" value="13">13
                                                <input type="checkbox" value="14">14
                                                <input type="checkbox" value="15">15
                                                <input type="checkbox" value="16">16
                                            </div>
                                            <div class="imp dayList">
                                                <input type="checkbox" value="17">17
                                                <input type="checkbox" value="18">18
                                                <input type="checkbox" value="19">19
                                                <input type="checkbox" value="20">20
                                                <input type="checkbox" value="21">21
                                                <input type="checkbox" value="22">22
                                                <input type="checkbox" value="23">23
                                                <input type="checkbox" value="24">24
                                                <input type="checkbox" value="25">25
                                                <input type="checkbox" value="26">26
                                                <input type="checkbox" value="27">27
                                                <input type="checkbox" value="28">28
                                                <input type="checkbox" value="29">29
                                                <input type="checkbox" value="30">30
                                                <input type="checkbox" value="31">31
                                            </div>
                                        </div>
                                    </div>
                                    <div id="cron-set-month" class="tab-pane fade">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="mouth" onclick="everyTime(this)">
                                                月 允许的通配符[, - * /]</div>
                                            <div class="line">
                                                <input type="radio" name="mouth" onclick="unAppoint(this)">
                                                不指定</div>
                                            <div class="line">
                                                <input type="radio" name="mouth" onclick="cycle(this)">
                                                周期从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:12" value="1" id="mouthStart_0"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:2,max:12" value="2" id="mouthEnd_0"><input type="hidden" value="2"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                月</div>
                                            <div class="line">
                                                <input type="radio" name="mouth" onclick="startOn(this)">
                                                从
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:12" value="1" id="mouthStart_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                日开始,每
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:12" value="1" id="mouthEnd_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                月执行一次</div>
                                            <div class="line">
                                                <input type="radio" name="mouth" id="mouth_appoint">
                                                指定</div>
                                            <div class="imp mouthList">
                                                <input type="checkbox" value="1">1
                                                <input type="checkbox" value="2">2
                                                <input type="checkbox" value="3">3
                                                <input type="checkbox" value="4">4
                                                <input type="checkbox" value="5">5
                                                <input type="checkbox" value="6">6
                                                <input type="checkbox" value="7">7
                                                <input type="checkbox" value="8">8
                                                <input type="checkbox" value="9">9
                                                <input type="checkbox" value="10">10
                                                <input type="checkbox" value="11">11
                                                <input type="checkbox" value="12">12
                                            </div>
                                        </div>
                                    </div>
                                    <div id="cron-set-week" class="tab-pane fade">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="week" onclick="everyTime(this)">
                                                周 允许的通配符[, - * / L #]</div>
                                            <div class="line">
                                                <input type="radio" name="week" onclick="unAppoint(this)" checked="checked">
                                                不指定</div>
                                            <div class="line">
                                                <input type="radio" name="week" onclick="startOn(this)">
                                                周期 从星期<span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:7" id="weekStart_0" value="1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:2,max:7" value="2" id="weekEnd_0"><input type="hidden" value="2"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span></div>
                                            <div class="line">
                                                <input type="radio" name="week" onclick="weekOfDay(this)">
                                                第<span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:4" value="1" id="weekStart_1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                周 的星期<span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:7" id="weekEnd_1" value="1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span></div>
                                            <div class="line">
                                                <input type="radio" name="week" onclick="lastWeek(this)">
                                                本月最后一个星期<span class="spinner" style="width: 58px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 36px; height: 20px; line-height: 20px;" data-options="min:1,max:7" id="weekStart_2" value="1"><input type="hidden" value="1"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span></div>
                                            <div class="line">
                                                <input type="radio" name="week" id="week_appoint">
                                                指定</div>
                                            <div class="imp weekList">
                                                <input type="checkbox" value="1">1
                                                <input type="checkbox" value="2">2
                                                <input type="checkbox" value="3">3
                                                <input type="checkbox" value="4">4
                                                <input type="checkbox" value="5">5
                                                <input type="checkbox" value="6">6
                                                <input type="checkbox" value="7">7
                                            </div>
                                        </div>
                                    </div>
                                    <div id="cron-set-year" class="tab-pane fade">
                                        <div class="container-fluid text-left">
                                            <div class="line">
                                                <input type="radio" checked="checked" name="year" onclick="unAppoint(this)">
                                                不指定 允许的通配符[, - * /] 非必填</div>
                                            <div class="line">
                                                <input type="radio" name="year" onclick="everyTime(this)">
                                                每年</div>
                                            <div class="line">
                                                <input type="radio" name="year" onclick="cycle(this)">周期 从
                                                <span class="spinner" style="width: 88px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 66px; height: 20px; line-height: 20px;" data-options="min:2013,max:3000" id="yearStart_0" value="2015"><input type="hidden" value="2015"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                                -
                                                <span class="spinner" style="width: 88px; height: 20px;"><input class="numberspinner numberspinner-f spinner-text spinner-f validatebox-text numberbox-f" style="width: 66px; height: 20px; line-height: 20px;" data-options="min:2014,max:3000" id="yearEnd_0" value="2016"><input type="hidden" value="2016"><span class="spinner-arrow" style="height: 20px;"><span class="spinner-arrow-up" style="height: 10px;"></span><span class="spinner-arrow-down" style="height: 10px;"></span></span></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="space-5"></div>
                            <div class="container-fluid">
                                <table style="height: 100px;">
                                    <tbody>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="center">
                                            秒
                                        </td>
                                        <td align="center">
                                            分钟
                                        </td>
                                        <td align="center">
                                            小时
                                        </td>
                                        <td align="center">
                                            日
                                        </td>
                                        <td align="center">
                                            月<br>
                                        </td>
                                        <td align="center">
                                            星期
                                        </td>
                                        <td align="center">
                                            年
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            表达式字段:
                                        </td>
                                        <td>
                                            <input type="text" name="v_second" class="input-mini" value="*" >
                                        </td>
                                        <td>
                                            <input type="text" name="v_min" class="input-mini" value="*" >
                                        </td>
                                        <td>
                                            <input type="text" name="v_hour" class="input-mini" value="*" >
                                        </td>
                                        <td>
                                            <input type="text" name="v_day" class="input-mini" value="*" >
                                        </td>
                                        <td>
                                            <input type="text" name="v_mouth" class="input-mini" value="*" >
                                        </td>
                                        <td>
                                            <input type="text" name="v_week" class="input-mini" value="?" >
                                        </td>
                                        <td>
                                            <input type="text" name="v_year" class="input-mini" >
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <input type="hidden" id="set-cron" name="set-cron" value="* * * * * ?">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="pull-right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-sm" id="cron-modal-btn-set">设置</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="application/javascript">
            $(document).ready(function () {
                function btnFan() {
                    //获取参数中表达式的值
                    var txt = $("#cron").val();
                    if (txt) {
                        var regs = txt.split(' ');
                        $("input[name=v_second]").val(regs[0]);
                        $("input[name=v_min]").val(regs[1]);
                        $("input[name=v_hour]").val(regs[2]);
                        $("input[name=v_day]").val(regs[3]);
                        $("input[name=v_mouth]").val(regs[4]);
                        $("input[name=v_week]").val(regs[5]);

                        initObj(regs[0], "second");
                        initObj(regs[1], "min");
                        initObj(regs[2], "hour");
                        initDay(regs[3]);
                        initMonth(regs[4]);
                        initWeek(regs[5]);

                        if (regs.length > 6) {
                            $("input[name=v_year]").val(regs[6]);
                            initYear(regs[6]);
                        }
                    }
                }


                function initObj(strVal, strid) {
                    var ary = null;
                    var objRadio = $("input[name='" + strid + "'");
                    if (strVal == "*") {
                        objRadio.eq(0).attr("checked", "checked");
                    } else if (strVal.split('-').length > 1) {
                        ary = strVal.split('-');
                        objRadio.eq(1).attr("checked", "checked");
                        $("#" + strid + "Start_0").numberspinner('setValue', ary[0]);
                        $("#" + strid + "End_0").numberspinner('setValue', ary[1]);
                    } else if (strVal.split('/').length > 1) {
                        ary = strVal.split('/');
                        objRadio.eq(2).attr("checked", "checked");
                        $("#" + strid + "Start_1").numberspinner('setValue', ary[0]);
                        $("#" + strid + "End_1").numberspinner('setValue', ary[1]);
                    } else {
                        objRadio.eq(3).attr("checked", "checked");
                        if (strVal != "?") {
                            $("." + strid + "List input").removeAttr("checked");
                            ary = strVal.split(",");
                            for (var i = 0; i < ary.length; i++) {
                                $("." + strid + "List input[value='" + ary[i] + "']").attr("checked", "checked");
                            }
                        }
                    }
                }

                function initDay(strVal) {
                    var ary = null;
                    var objRadio = $("input[name='day']");
                    if (strVal == "*") {
                        objRadio.eq(0).attr("checked", "checked");
                    } else if (strVal == "?") {
                        objRadio.eq(1).attr("checked", "checked");
                    } else if (strVal.split('-').length > 1) {
                        ary = strVal.split('-');
                        objRadio.eq(2).attr("checked", "checked");
                        $("#dayStart_0").numberspinner('setValue', ary[0]);
                        $("#dayEnd_0").numberspinner('setValue', ary[1]);
                    } else if (strVal.split('/').length > 1) {
                        ary = strVal.split('/');
                        objRadio.eq(3).attr("checked", "checked");
                        $("#dayStart_1").numberspinner('setValue', ary[0]);
                        $("#dayEnd_1").numberspinner('setValue', ary[1]);
                    } else if (strVal.split('W').length > 1) {
                        ary = strVal.split('W');
                        objRadio.eq(4).attr("checked", "checked");
                        $("#dayStart_2").numberspinner('setValue', ary[0]);
                    } else if (strVal == "L") {
                        objRadio.eq(5).attr("checked", "checked");
                    } else {
                        objRadio.eq(6).attr("checked", "checked");
                        ary = strVal.split(",");
                        for (var i = 0; i < ary.length; i++) {
                            $(".dayList input[value='" + ary[i] + "']").attr("checked", "checked");
                        }
                    }
                }

                function initMonth(strVal) {
                    var ary = null;
                    var objRadio = $("input[name='mouth']");
                    if (strVal == "*") {
                        objRadio.eq(0).attr("checked", "checked");
                    } else if (strVal == "?") {
                        objRadio.eq(1).attr("checked", "checked");
                    } else if (strVal.split('-').length > 1) {
                        ary = strVal.split('-');
                        objRadio.eq(2).attr("checked", "checked");
                        $("#mouthStart_0").numberspinner('setValue', ary[0]);
                        $("#mouthEnd_0").numberspinner('setValue', ary[1]);
                    } else if (strVal.split('/').length > 1) {
                        ary = strVal.split('/');
                        objRadio.eq(3).attr("checked", "checked");
                        $("#mouthStart_1").numberspinner('setValue', ary[0]);
                        $("#mouthEnd_1").numberspinner('setValue', ary[1]);

                    } else {
                        objRadio.eq(4).attr("checked", "checked");

                        ary = strVal.split(",");
                        for (var i = 0; i < ary.length; i++) {
                            $(".mouthList input[value='" + ary[i] + "']").attr("checked", "checked");
                        }
                    }
                }

                function initWeek(strVal) {
                    var ary = null;
                    var objRadio = $("input[name='week']");
                    if (strVal == "*") {
                        objRadio.eq(0).attr("checked", "checked");
                    } else if (strVal == "?") {
                        objRadio.eq(1).attr("checked", "checked");
                    } else if (strVal.split('/').length > 1) {
                        ary = strVal.split('/');
                        objRadio.eq(2).attr("checked", "checked");
                        $("#weekStart_0").numberspinner('setValue', ary[0]);
                        $("#weekEnd_0").numberspinner('setValue', ary[1]);
                    } else if (strVal.split('-').length > 1) {
                        ary = strVal.split('-');
                        objRadio.eq(3).attr("checked", "checked");
                        $("#weekStart_1").numberspinner('setValue', ary[0]);
                        $("#weekEnd_1").numberspinner('setValue', ary[1]);
                    } else if (strVal.split('L').length > 1) {
                        ary = strVal.split('L');
                        objRadio.eq(4).attr("checked", "checked");
                        $("#weekStart_2").numberspinner('setValue', ary[0]);
                    } else {
                        objRadio.eq(5).attr("checked", "checked");
                        ary = strVal.split(",");
                        for (var i = 0; i < ary.length; i++) {
                            $(".weekList input[value='" + ary[i] + "']").attr("checked", "checked");
                        }
                    }
                }

                function initYear(strVal) {
                    var ary = null;
                    var objRadio = $("input[name='year']");
                    if (strVal == "*") {
                        objRadio.eq(1).attr("checked", "checked");
                    } else if (strVal.split('-').length > 1) {
                        ary = strVal.split('-');
                        objRadio.eq(2).attr("checked", "checked");
                        $("#yearStart_0").numberspinner('setValue', ary[0]);
                        $("#yearEnd_0").numberspinner('setValue', ary[1]);
                    }
                }
                $("#cron-modal").on("hidden.bs.modal", function () {
                    $(this).removeData('bs.modal');
                    $("#set-cron-form")[0].reset();
                })
                $("#cron-modal").on("show.bs.modal", function () {
                    btnFan();
                })
                $("#cron-modal-btn-set").click(function () {
                    $("#cron").val($("#set-cron").val());
                    $("#cron-modal").modal("hide");

                });
            });
        </script>
<script type="application/javascript">
    $(document).ready(function(){
        $('#validation-form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            ignore: "",
            rules: {
                name:{
                    required:true
                },
                url:{
                    required:true
                },
                cron:{
                    required:true
                },
                numberOfCrawler:{
                    required:true
                }
            },

            messages:{

            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
                $(e).remove();
            },

            errorPlacement: function (error, element) {
                if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
                    var controls = element.closest('div[class*="col-"]');
                    if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if(element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if(element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element.parent());
            }
        });
    });
</script>
</body>
</html>
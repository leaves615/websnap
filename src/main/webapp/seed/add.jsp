<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="w" uri="http://www.zjhtc.com/tags/pager"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://zjht.com/jsp/tag/form" %>
<!doctype html>
<html lang="zh">
<head>
	<title>网站管理</title>
    <jsp:include page="/include/commons-include.jsp"/>
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
                    <li class="active">网站管理</li>
                </ul><!-- /.breadcrumb -->
                <div class="pull-right">
                    <div class="btn-group">
                        <a href="/seed/add" class="btn btn-default btn-sm">添加</a>
                    </div>
                </div>
            </div><!-- 主内容顶部导航结束 -->


 <div class="page-content">
      <div class="row">
          <div class="col-xs-12">
              <form class="form-horizontal" action="/seed/add" method="post" id="form">
                  <h3 class="lighter block green">添加网站</h3>
                  <form:input label="网站名称：" name="name"/>
                  <form:input label="URL：" name="url" extendAttribute="placeholder='http://'"/>
                  <form:input label="计划：" name="cron"/>
                  <form:input label="并发数：" name="numberOfCrawler" inputType="number" className="col-sm-3"/>
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
</body>
</html>
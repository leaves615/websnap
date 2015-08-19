<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="w" uri="http://www.zjhtc.com/tags/pager"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                    <li>抓取内容管理</li>
                    <li class="active">抓取记录</li>
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
              <form method="get" class="form-inline" role="form" enctype="application/x-www-form-urlencoded">
                  <div class="form-group">
                      <label>网站:</label>
                      <select id="seedid" name="seedid" class="form-control input-sm">
                          <option value="">--请选择--</option>
                          <c:forEach items="${seeds}" var="item">
                              <c:choose>
                                  <c:when test="${item.id == record.seedid}">
                                      <option value="${item.id}" selected>${item.name}</option>
                                  </c:when>
                                  <c:otherwise>
                                      <option value="${item.id}">${item.name}</option>
                                  </c:otherwise>
                              </c:choose>
                          </c:forEach>
                        </select>
                  </div>
                  <div class="form-group">
                            <label>标题:</label>
                        <input type="text" id="title" name="title" value="${record.title}" class="form-control input-sm">
                  </div>
                  <div class="form-group">
                        <label>发送内容:</label>
                        <input type="text" id="fetchtime" name="fetchtimeString" value="${record.fetchtimeString}" class="form-control input-sm">
                  </div>
                  <div class="form-group">
                        <button type="submit" class="btn btn-sm">查询</button>
                        <button type="reset" class="btn btn-sm">重置</button>
                  </div>
            </form>
          </div>
	  </div>
	  
	<div class="hr hr-16 hr-dotted"></div>
                <div class="row">
                    <div class="col-xs-12">  
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <td>编号</td>
                                <td>标题</td>
                                <td>url</td>
                                <td>抓取时间</td>
                                <td width="100">操作</td>
                            </tr>
                            </thead>
                         <tbody>
                            <c:if test="${!empty page.list}">
                                <c:forEach items="${page.list}" var="item">
                                    <tr>
                                        <td>${item.id}</td>
                                        <td>${item.title}</td>
                                        <td>${item.weburl}</td>
                                        <td><fmt:formatDate value="${item.fetchtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>
                                            <a href="/pages/${item.id}" class="btn btn-white btn-mini" data-toggle="modal" data-target="#modal">查看</a>
                                            <div id="modal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">

                                                    </div>
                                                </div>
                                            </div>
                                            <script type="application/javascript">
                                                $(document).ready(function () {
                                                    $("#modal").on("hidden.bs.modal", function () {
                                                        $(this).removeData('bs.modal');
                                                        $(this).find(".modal-content").html('');
                                                    })
                                                });
                                            </script>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                         </tbody>
                        </table>
	                </div>
                    <div class="col-xs-12 text-right">
                        <c:if test="${page!=null}">
                            <w:pager pageSize="${page.pageSize}" pageNo="${page.pageNum}"
                                    url="${ctx}/pages/list" recordCount="${page.total}" />
                        </c:if>
                    </div>
	            </div>
	</div>
	</div>
	</div><!--右侧主内容结束 -->
</div>
<script type="application/javascript">
    var getHost = function(url) {
        var host = "null";
        if(typeof url == "undefined"
                || null == url)
            url = window.location.href;
        var regex = /(.*\:\/\/[^\/]*)/;
        var match = url.match(regex);
        if(typeof match != "undefined"
                && null != match)
            host = match[1];
        return host;
    }
    var getDir = function(url){
        if(url.indexOf("?")>0)
            url = url.substring(0,url.indexOf("?"))
        return url.substring(0,url.lastIndexOf("/")+1)
    }
</script>
</body>
</html>

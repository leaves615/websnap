<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
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
                    <li>爬虫管理</li>
                    <li class="active">网站管理</li>
                    <li class="active">页面提取规则列表</li>
                </ul><!-- /.breadcrumb -->
                <div class="pull-right">
                    <div class="btn-group">
                        <a href="${ctx}/seed/${seedid}/pageRule/${ruleid}/content/add" class="btn btn-default btn-sm">添加</a>
                    </div>
                </div>
            </div><!-- 主内容顶部导航结束 -->


 <div class="page-content">
        <div class="row">
            <div class="col-xs-12">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <td width="50">编号</td>
                        <td>变量名</td>
                        <td>获取方式</td>
                        <td>名称</td>
                        <td>是否存储</td>
                        <td>是否判断</td>
                        <td>判断条件</td>
                        <td width="200">操作</td>
                    </tr>
                    </thead>
                 <tbody>
                    <c:if test="${!empty page.list}">
                        <%
                            Map<String, String> collectTypeMap = new HashMap<String, String>();
                            collectTypeMap.put("regex", "正则表达式");
                            collectTypeMap.put("html", "html选择器");
                            request.setAttribute("collectTypeMap", collectTypeMap);
                            Map<String, String> storageMap = new HashMap<String, String>();
                            storageMap.put("false", "不存储");
                            storageMap.put("true", "存储");
                            request.setAttribute("storageMap", storageMap);
                            Map<String, String> conditionalMap = new HashMap<String, String>();
                            conditionalMap.put("false", "无");
                            conditionalMap.put("true", "条件判断");
                            request.setAttribute("conditionalMap", conditionalMap);
                        %>
                        <c:forEach items="${page.list}" var="item">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.collectvar}</td>
                                <td>${collectTypeMap[item.collecttype]}</td>
                                <td>${item.collectlabel}</td>
                                <td>${storageMap[item.storage.toString()]}</td>
                                <td>${conditionalMap[item.conditional.toString()]}</td>
                                <td>${item.conditionpattern}</td>
                                <td>
                                    <a href="${ctx}/seed/${seedid}/pageRule/${ruleid}/content/${item.id}/update" class="btn btn-white btn-mini">编辑</a>
                                    <a href="${ctx}/seed/${seedid}/pageRule/${ruleid}/content/${item.id}/delete" class="btn btn-white btn-mini">删除</a>
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
                            url="${ctx}/seed/${seedid}/pageRule/list" recordCount="${page.total}" />
                </c:if>
            </div>
        </div>
	</div>
	</div>
	</div><!--右侧主内容结束 -->
</div>
</body>
</html>
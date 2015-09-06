<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
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
                    <li>网站管理</li>
                    <li class="active">添加页面匹配条件</li>
                </ul><!-- /.breadcrumb -->
            </div><!-- 主内容顶部导航结束 -->


 <div class="page-content">
      <div class="row">
          <div class="col-xs-12">
              <form class="form-horizontal" action="${ctx}/seed/${seedid}/pageRule/add" method="post" id="form">
                  <h3 class="lighter block green">添加页面匹配条件</h3>
                  <input type="hidden" name="seedid" value="${seedid}"/>
                  <%
                      Map<String, String> matchTypeMap = new HashMap<String, String>();
                      matchTypeMap.put("regex", "正则表达式");
                      matchTypeMap.put("antStyle", "通配符");
                      request.setAttribute("matchTypeMap", matchTypeMap);
                  %>
                  <form:select label="匹配方式：" name="matchtype" map="${matchTypeMap}" value="${rule.matchtype}"/>
                  <form:input label="表达式：" name="pattern" value="${rule.pattern}"/>
                  <div class="form-group">
                      <label class="control-label col-xs-12 col-sm-3 no-padding-right"></label>
                      <div class="col-xs-12 col-sm-9">
                          <div class="bg-info text-left">
                              填写对应匹配方式的正确表达式：<br>
                              正则表达式：此域中应为正确的正则表达式。
                              通配符：为antStype 样式的表达式
                          </div>
                      </div>
                  </div>
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
<script type="application/javascript">
    $(document).ready(function(){
        $('#validation-form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            ignore: "",
            rules: {
                matchType:{
                    required:true
                },
                pattern:{
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
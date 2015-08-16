<%--
  Created by IntelliJ IDEA.
  User: leaves chen<leaves615@gmail.com>
  Date: 15/5/8
  Time: 13:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="zh">
<head>
    <title>虚拟账户系统控制台</title>
    <jsp:include page="/include/commons-include.jsp"/>
</head>
<body class="no-skin">
<!--顶部导航栏-->
<jsp:include page="/include/commons-navbar.jsp"/>
<!-- 主框架 -->
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
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
                    try {
                        ace.settings.check('breadcrumbs', 'fixed')
                    } catch (e) {
                    }
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}">Home</a>
                    </li>
                    <li class="active">Dashboard</li>
                </ul>
                <!-- /.breadcrumb -->

            </div>
            <!-- 主内容顶部导航结束 -->

            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <!-- 主内容 -->
                    </div>
                </div>
            </div>
            <!-- /.page-content -->
        </div>

    </div>
    <!--右侧主内容结束 -->
</div>
</body>
</html>
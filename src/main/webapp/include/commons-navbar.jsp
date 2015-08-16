<%--
  Created by IntelliJ IDEA.
  User: leaves chen<leaves615@gmail.com>
  Date: 15/5/6
  Time: 15:44
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="navbar" class="navbar navbar-default">
  <script type="text/javascript">
    try{ace.settings.check('navbar' , 'fixed')}catch(e){}
  </script>

  <div class="navbar-container" id="navbar-container">
    <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
      <span class="sr-only">Toggle sidebar</span>

      <span class="icon-bar"></span>

      <span class="icon-bar"></span>

      <span class="icon-bar"></span>
    </button>

    <div class="navbar-header pull-left">
      <a href="${ctx }/" class="navbar-brand">
          <small>
              <i class="fa fa-leaf"></i>
                管理平台
          </small>
      </a>
    </div>

    <div class="navbar-buttons navbar-header pull-right" role="navigation">
      <ul class="nav ace-nav">
        <li class="light-blue">
          <a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<span class="user-info">
									<small>欢迎,</small>
								</span>

            <i class="ace-icon fa fa-caret-down"></i>
          </a>

          <%--<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">--%>
            <%--<li>--%>
              <%--<a href="#">--%>
                <%--<i class="ace-icon fa fa-user"></i>--%>
                <%--我的信息--%>
              <%--</a>--%>
            <%--</li>--%>

            <%--<li class="divider"></li>--%>

            <%--<li>--%>
              <%--<a href="${ctx}/logout.do">--%>
                <%--<i class="ace-icon fa fa-power-off"></i>--%>
                <%--退出--%>
              <%--</a>--%>
            <%--</li>--%>
          <%--</ul>--%>
        </li>
      </ul>
    </div>
  </div><!-- /.navbar-container -->
</div>
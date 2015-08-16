<%--
  Created by IntelliJ IDEA.
  User: leaves chen<leaves615@gmail.com>
  Date: 15/5/6
  Time: 15:59
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="sidebar" class="sidebar                  responsive">
    <script type="text/javascript">
        try {
            ace.settings.check('sidebar', 'fixed')
        } catch (e) {
        }
    </script>
    <ul class="nav nav-list">
            <li class="active">
                <a href="${ctx }/index.do">
                    <i class="menu-icon fa fa-tachometer"></i>
                    <span class="menu-text">Dashboard</span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-user"></i>
                    <span class="menu-text">
                        爬虫管理
                    </span>
                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>
                <ul class="submenu">
                        <li class="">
                            <a href="${ctx }/seed/list">
                                <i class="menu-icon fa fa-caret-right"></i>
                                <span>网站管理</span>
                            </a>
                            <b class="arrow"></b>
                        </li>
                    </ul>
            </li>
        </ul>
        <!-- /.nav-list -->
    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
        <i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left"
           data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
    <script type="text/javascript">
        try {
            ace.settings.check('sidebar', 'collapsed')
        } catch (e) {
        }
    </script>
    <script type="application/javascript">
        $(document).ready(function () {
            var breadcrumbItems = $("#breadcrumbs li");
            var sidebarItems = $("#sidebar a");
            var currentItem;
            for (j in breadcrumbItems) {
                var found = false;
                for (i in sidebarItems) {
                    if ($(sidebarItems[i]).find("span").text().trim() == $(breadcrumbItems[(breadcrumbItems.length - 1 - j)]).text().trim()) {
                        currentItem = sidebarItems[i];
                        found = true;
                        break;
                    }
                }
                if (found) break;
            }
            if (currentItem != undefined) {
                var newActive = $(currentItem).parent();
                $('#sidebar .nav-list li.active').removeClass('active');
                newActive.addClass('active').parents('.nav-list li').addClass('active open');
            }
        });
    </script>
</div>

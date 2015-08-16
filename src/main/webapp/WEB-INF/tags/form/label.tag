<%@ tag import="java.util.UUID" %>
<%--
  Created by IntelliJ IDEA.
  User: leaves chen<leaves615@gmail.com>
  Date: 15/8/7
  Time: 10:10
--%>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="label" type="java.lang.String" required="true"%>
<%@attribute name="value" type="java.lang.String" rtexprvalue="true"%>
<div class="form-group">
    <label class="control-label col-xs-12 col-sm-3 no-padding-right">${label}</label>
    <div class="col-xs-12 col-sm-9">
        <label class="control-label">${value}</label>
    </div>
</div>
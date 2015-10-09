<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: leaves chen<leaves615@gmail.com>
  Date: 15/8/7
  Time: 10:10
--%>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="label" type="java.lang.String" required="true"%>
<%@attribute name="name" type="java.lang.String" rtexprvalue="true" required="true" %>
<%@attribute name="value" type="java.lang.String" rtexprvalue="true"  %>
<%@attribute name="inputType" type="java.lang.String" description="input type类型" %>
<%@attribute name="className" type="java.lang.String" description="input Class" %>
<%@attribute name="extendAttribute" type="java.lang.String" description="表单域其它html属性" %>

<div class="form-group">
    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="${name}">${label}</label>
    <div class="col-xs-12 col-sm-9">
        <div class="clearfix">
            <input id="${name}" type="${inputType==null?'text':inputType}" name="${name}" value="${value}" class=" ${className==null?'col-xs-12 col-sm-5':className}" ${extendAttribute}>
        </div>
    </div>
</div>
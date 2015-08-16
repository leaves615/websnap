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
<%@attribute name="map" type="java.util.Map" description="select 选项map" %>
<%@attribute name="className" type="java.lang.String" description="input Class" %>
<%@attribute name="extendAttribute" type="java.lang.String" description="表单域其它html属性" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="form-group">
    <label class="control-label col-xs-12 col-sm-3 no-padding-right" for="${name}">${label}</label>
    <div class="col-xs-12 col-sm-9">
        <div class="clearfix">
            <select id="${name}"  name="${name}" value="${value}" class="${className}" ${extendAttribute}>
                <c:forEach items="${map}" var="entry">
                    <c:choose>
                        <c:when test="${entry.key == value}">
                            <option value="${entry.key}" selected>${entry.value}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${entry.key}">${entry.value}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
    </div>
</div>
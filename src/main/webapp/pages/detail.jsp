<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: leaves chen<leaves615@gmail.com>
  Date: 15/8/18
  Time: 21:30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title">抓取内容</h4>
</div>
<div class="modal-body">
    <div class="form-horizontal">
        <div class="form-group">
            <label class="control-label col-xs-12 col-sm-2 no-padding-right">网页标题:</label>
            <div class="col-xs-12 col-sm-10">
                <div>${page.title}</div>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-12 col-sm-2 no-padding-right">网页URL:</label>
            <div class="col-xs-12 col-sm-10">
                <div id="pageUrl">${page.weburl}</div>
                <input type="hidden" id="baseDomain" value="${baseDomain}">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-12 col-sm-2 no-padding-right">抓取时间:</label>
            <div class="col-xs-12 col-sm-10">
                <div><fmt:formatDate value="${page.fetchtime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
            </div>
        </div>
        <c:forEach items="${contents}" var="item">
            <div class="form-group">
                <label class="control-label col-xs-12 col-sm-2 no-padding-right">${ruleMap[item.contentruleid].collectlabel}:</label>
                <div class="col-xs-12 col-sm-10">
                    <div class="pageContent">${item.content}</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    var domain = getHost($("#baseDomain").val());
    var path = getDir($("#baseDomain").val());
    $("#modal").find("a,img").each(function () {
        var _this = $(this);
        if(_this.attr("src")) {
            if(_this.attr("src").indexOf("http")>0) return;
            if(_this.attr("src").charAt(0)=="/"){
                _this.attr("src", domain + _this.attr("src"));
                return;
            }else{
                _this.attr("src", path + _this.attr("src"));
                return;
            }
        }
        if(_this.attr("href")) {
            if(!_this.attr("target")){
                _this.attr("target", "_blank");
            }
            if(_this.attr("href").charAt(0)=="/"){
                _this.attr("href", domain + _this.attr("href"));
                return;
            }else{
                _this.attr("href", path + _this.attr("href"));
                return;
            }
        }

    });
</script>
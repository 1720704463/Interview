<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/3/3
  Time: 22:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>考试结果列表</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <script src="${pageContext.request.contextPath}/statics/foreground/js/resultList.js"></script>
</head>
<body>
<jsp:include page="commonHeader.jsp"/>
<main class="container">
  <h2 class="text-center text-primary">考试结果列表</h2>
  <!--考试结果列表-->
  <div id="resultList">
    <div class="panel panel-primary resultPrototype hide">
      <div class="panel-heading container-fluid">
        <span class="col-md-3 panel-title examTitle">考试名称</span>
        <span class="col-md-9 text-right text-nowrap examTime">日期</span>
      </div>
      <div class="panel-body">
        <div class="btn-group btn-group-justified">
          <a href="${pageContext.request.contextPath}" class="btn btn-default">查看趋势</a>
          <a href="${pageContext.request.contextPath}" class="btn btn-default">查看分析</a>
          <a href="${pageContext.request.contextPath}" class="btn btn-default seeDetail">查看详情</a>
        </div>
      </div>
    </div>
  </div>
  <div class="alert alert-info fade in" id="prompt" style="display: none;">
    <a class="close" data-dismiss="alert" href="#">&times;</a>
    <span></span>
  </div>
</main>
</body>
</html>

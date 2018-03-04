<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/2/26
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>首页</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <script src="${pageContext.request.contextPath}/statics/foreground/js/home.js"></script>
</head>
<body class="container">
<%--引入公用的头部--%>
<jsp:include page="commonHeader.jsp"/>
<h1 class="text-center text-primary">面试题目列表</h1>
<!--搜索和添加面试题目-->
<form action="#">
  <div class="input-group">
    <input type="text" class="form-control" id="searchTopicTitle" required placeholder="面试题目标题">
    <div class="input-group-btn">
      <button class="btn btn-default" type="submit">
        <span class="glyphicon glyphicon-search"></span>
      </button>
    </div>
  </div>
</form>
<br/>
<!--面试题目列表-->
<main class="topicList">
  <%--面试题目原型--%>
  <div class="panel panel-default topicProperty hide">
    <div class="panel-heading">
      <%--面试题目的类型编号与类型名称--%>
      <span class="label label-info typeTitle" typeId=""></span>
      <!--题目标题-->
      <h4 style="display: inline;" class="topicTitle"></h4>
    </div>
    <!--默认隐藏面板（之所以嵌套 div 是为了动画顺畅），此处的 id 属性应该是 topic 的题目编号（可以保证唯一性）-->
    <div class="panel-collapse collapse" id="">
      <%--放置题目的答案--%>
      <div class="panel-body referenceAnswer"></div>
    </div>
    <div class="panel-footer">
      <div>
        <!--最后修改时间（计算日期之差）-->
        <span class="badge updateTime">最后修改于 2015-12-11</span>
        <div class="btn-group">
          <!--显示答案，此处的 data-target 属性值应当是 # + topic 的编号-->
          <button class="btn btn-default btnReferenceAnswerToggle" data-toggle="collapse" data-target="">
            显示参考答案
          </button>
          <!--操作菜单-->
          <div class="btn-group">
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
              操作 <span class="caret"></span></button>
            <ul class="dropdown-menu" role="menu">
              <li>
                <a href="#" class="updateTopic" topicId="">评论</a>
              </li>
              <li>
                <a href="#" class="deleteTopic" topicId="">反馈</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>
<div class="alert alert-info fade in" id="prompt" style="display: none;">
  <a class="close" data-dismiss="alert" href="#">&times;</a>
  <span></span>
</div>
</body>
</html>
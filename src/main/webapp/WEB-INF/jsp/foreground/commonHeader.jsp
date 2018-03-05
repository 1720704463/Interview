<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/3/3
  Time: 8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>公用的顶端</title>
  <!--引入 Bootstrap,jQuery 相关类库(在被其他页面引用后禁止再次引用相同的文件,避免 css/js 冲突)-->
  <%--<link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>--%>
  <%--<script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>--%>
  <%--<script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>--%>

  <link href="${pageContext.request.contextPath}/statics/foreground/css/commonHeader.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/foreground/js/commonHeader.js"></script>
</head>
<!--添加一个导航栏-->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <!--设置导航栏的尺寸-->
  <div class="container-fluid">
    <!--导航栏的标题-->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse"
              data-target="#example-navbar-collapse">
        <span class="sr-only">切换导航</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath}/user/home">Interview</a>
    </div>
    <div class="collapse navbar-collapse" id="example-navbar-collapse">
      <!--面试题目相关-->
      <ul class="nav navbar-nav navbar-left">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            面试题目
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/user/home">查询全部</a></li>
            <li><a href="#">分类查询</a></li>
            <li><a href="${pageContext.request.contextPath}/user/submitTopic">提交题目</a></li>
          </ul>
        </li>
      </ul>
      <!--考试相关-->
      <ul class="nav navbar-nav navbar-left">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            考试相关
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="${pageContext.request.contextPath}/user/userTestPage">进行考试</a></li>
            <li><a href="#">查询考试</a></li>
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-left">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            其他
            <b class="caret"></b>
          </a>
          <ul class="dropdown-menu">
            <li><a href="#">帮助</a></li>
            <li><a href="#">反馈</a></li>
            <li><a href="${pageContext.request.contextPath}/statics/foreground/resources/app/interviewBeta_1.0.apk">安卓下载</a></li>
          </ul>
        </li>
      </ul>
      <!--右侧-->
      <!--未登录前-->
      <div class="nav navbar-form navbar-right hide" id="userNoLogin">
        <a href="${pageContext.request.contextPath}/user/register" class="btn btn-primary">
          <span class="glyphicon glyphicon-user"></span>
          注册
        </a>
        <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
          <span class="glyphicon glyphicon-log-in"></span>
          登录
        </a>
      </div>
      <!--登陆后的 用户相关-->
      <ul class="nav navbar-nav navbar-right hide" id="userAlreadyLogin">
        <li class="dropdown">
          <!--用户头像-->
          <a href="#" class="dropdown-toggle userPictureImage" data-toggle="dropdown">
            <img
                src="${pageContext.request.contextPath}"
                class="img-circle"/>
            <!--<b class="caret"></b>-->
          </a>
          <ul class="dropdown-menu">
            <li><a href="#">用户信息</a></li>
            <li><a href="${pageContext.request.contextPath}/user/logout">注销登陆</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<%--
  添加代表一个绝对路径的属性
  用来方便 js 获取绝对路径
--%>
<p id="rootContextPath">${pageContext.request.contextPath}</p>

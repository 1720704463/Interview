<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/3/1
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>用户测验</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <link href="${pageContext.request.contextPath}/statics/foreground/css/userTestPage.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/statics/foreground/js/userTestPage.js"></script>
</head>
<body>
<main class="container">
  <h2 class="text-primary text-center">用户测验页面</h2>
  <form action="" method="post">
    <!--面试题目标题-->
    <ul id="idList" class="nav nav-pills">
      <li class="idProtoType" style="display: none;">
        <a href="#idProtoType" data-toggle="tab">第 1 题</a>
      </li>

    </ul>
    <!--面试题目答案,由用户负责完成-->
    <div id="topicList" class="tab-content">
      <div class="tab-pane fade in topicPrototype" id="idProtoType" style="display: none;">
        <h4 class="titlePrototype">原型题目标题</h4>
        <textarea class="answerPrototype form-control" title="填写你的答案" rows="8"></textarea>
      </div>
    </div>
    <!--提交答案的按钮组-->
    <div class="btn-group btn-group-justified submitUserTest" style="margin-top: 20px;">
      <div class="btn-group">
        <button type="submit" class="btn btn-primary">提交</button>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-primary">清空</button>
      </div>
      <div class="btn-group">
        <a href="${pageContext.request.contextPath}/user/home" class="btn btn-primary">首页</a>
      </div>
    </div>
  </form>
</main>
</body>
</html>
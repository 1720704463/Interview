<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/3/5
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>考试详情</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <script src="${pageContext.request.contextPath}/statics/foreground/js/resultDetail.js"></script>
</head>
<body>
<jsp:include page="commonHeader.jsp"/>
<main class="container">
  <h2 class="text-center text-info">考试详情</h2>
  <!--面试题目序号列表-->
  <ul id="idList" class="nav nav-pills">
    <li class="idProtoType hide">
      <a href="#idProtoType" data-toggle="tab">第 1 题</a>
    </li>

  </ul>
  <!--面试题目标题答案列表,由用户负责完成-->
  <div id="topicList" class="tab-content">
    <div class="tab-pane fade in topicPrototype hide" id="idProtoType">
      <div class="panel panel-info">
        <div class="panel-heading">
          <h4 class="title">原型题目标题</h4>
        </div>
        <div class="panel-body" style="margin-bottom: 0;">
          <table class="table" style="margin-bottom: 0;">
            <tr>
              <td style="width: 5rem;">你的答案:</td>
              <td class="userAnswer">用户的答案</td>
            </tr>
            <tr>
              <td nowrap>参考答案:</td>
              <td class="answer">用户的答案</td>
            </tr>

          </table>
        </div>

      </div>
    </div>

  </div>
</main>
</body>
</html>
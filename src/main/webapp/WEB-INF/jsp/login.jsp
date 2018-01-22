<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/1/18
  Time: 20:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>登录页面</title>
</head>
<body>
<span style="color: red;">${info}</span>
<form action="${pageContext.request.contextPath}/loginExecute" method="post">
  <label>
    用户名：
    <input type="text" name="username"/>
  </label>
  <label>
    密码：
    <input type="password" name="password"/>
  </label>
  <button type="submit">登录</button>
</form>
</body>
</html>

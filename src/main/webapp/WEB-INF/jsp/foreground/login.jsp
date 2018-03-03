<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/1/18
  Time: 20:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>用户登录</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>
  <!--当前页面-->
  <script src="${pageContext.request.contextPath}/statics/foreground/js/login.js"></script>
</head>
<body>
<%--引入公用的头部--%>
<jsp:include page="commonHeader.jsp"/>
<div class="container">
  <div class="card card-login mx-auto mt-5 form-login">
    <h2 class="card-header text-primary text-center">用户登录</h2>
    <div class="card-body">
      <form method="post" class="text-white">
        <div class="form-group">
          <label for="username">登录名</label>
          <input type="text" class="form-control" name="adminName" id="username" required/>
        </div>
        <div class="form-group">
          <label for="password">密码</label>
          <input type="password" class="form-control" name="password" id="password" required/>
        </div>
        <div class="check-box">
          <label class="text-white">
            <input type="checkbox" value="remember" name="remember" id="remember"/>记住密码
          </label>
        </div>
        <div class="btn-group btn-group-justified">
          <div class="btn-group">
            <button type="submit" class="btn btn-primary">登录</button>
          </div>
          <div class="btn-group">
            <button type="reset" class="btn btn-primary">重置</button>
          </div>
          <div class="btn-group">
            <a href="${pageContext.request.contextPath}/user/register" class="btn btn-primary">注册</a>
          </div>
          <div class="btn-group">
            <a href="${pageContext.request.contextPath}/user/home" class="btn btn-primary">首页</a>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

</body>
</html>
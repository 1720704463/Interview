<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/2/27
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>注册</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/foreground/css/register.css">
  <script src="${pageContext.request.contextPath}/statics/foreground/js/register.js"></script>
</head>
<body>
<%--引入公用的头部--%>
<jsp:include page="commonHeader.jsp"/>
<main class="container">
  <div class="card card-login mx-auto mt-5 form-register">
    <h2 class="card-header text-primary text-center">用户注册</h2>
    <div class="card-body">
      <form method="post" class="text-white">
        <div class="form-group">
          <label for="username">登录名</label>
          <input type="text" class="form-control" id="username" required/>
          <span>&nbsp;</span>
        </div>
        <div class="form-group">
          <label for="password">密码</label>
          <input type="password" class="form-control" id="password" required/>
          <span>&nbsp;</span>
        </div>
        <div class="form-group">
          <label for="email">邮箱</label>
          <input type="email" class="form-control" id="email" required/>
          <span>&nbsp;</span>
        </div>
        <div class="btn-group btn-group-justified">
          <div class="btn-group">
            <button type="submit" class="btn btn-primary btnRegister">注册</button>
          </div>
          <div class="btn-group">
            <button type="reset" class="btn btn-primary">重置</button>
          </div>
        </div>
        <br/>
      </form>
    </div>
  </div>
  <div class="alert alert-success alertRegister fade in" style="display: none;">
    注册成功，即将跳转到首页！
  </div>
</main>

</body>
</html>

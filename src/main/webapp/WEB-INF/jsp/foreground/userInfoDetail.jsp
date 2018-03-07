<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/3/7
  Time: 8:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>用户详情</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <script src="${pageContext.request.contextPath}/statics/foreground/js/userInfoDetail.js"></script>
</head>
<body>
<jsp:include page="commonHeader.jsp"/>
<main class="container">
  <h2 class="text-primary text-center">用户的详细信息</h2>
  <div class="container-fluid">
    <!--导航菜单-->
    <div class="col-md-3">
      <ul class="nav nav-pills nav-stacked">
        <li class="active">
          <a href="#userInfo" data-toggle="tab">详细信息</a>
        </li>
        <li>
          <a href="#safety" data-toggle="tab">安全相关</a>
        </li>
        <li>
          <a href="#" id="removeUser" class="text-danger" data-toggle="tab">销毁账号</a>
        </li>
      </ul>
    </div>
    <!--具体的操作面板-->
    <div class="col-md-9">
      <div class="tab-content">
        <!--用户详细信息-->
        <div class="tab-pane fade in active" id="userInfo">
          <form class="form-horizontal" id="updateUserInfo">
            <div class="form-group">
              <label for="nickname">昵称：</label>
              <input type="text" class="form-control" id="nickname"/>
            </div>
            <div class="form-group">
              <label for="realname">真实姓名：</label>
              <input type="text" class="form-control" id="realname"/>
            </div>
            <div class="form-group">
              <label>头像：</label>
              <!--suppress CheckImageSize -->
              <img
                  src="${pageContext.request.contextPath}/statics/foreground/image/user/395227749440163840_pictureImage.jpg"
                  width="30" height="30"
                  class="img-circle" id="oldPicture"/>
              <input type="file" id="newPicture"/>
              <p class="help-block">上传新的头像</p>
            </div>
            <div class="form-group">
              <label for="birthday">生日：</label>
              <input type="date" class="form-control" id="birthday"/>
            </div>
            <div class="form-group">
              <label for="gender">性别：</label>
              <div id="gender">
                <label class="radio-inline">
                  <input type="radio" name="gender" value="0"> 女
                </label>
                <label class="radio-inline">
                  <input type="radio" name="gender" value="1"> 男
                </label>
                <label class="radio-inline">
                  <input type="radio" name="gender" value="-1"> 保密
                </label>
              </div>
            </div>
            <div class="form-group">
              <label for="address">地址：</label>
              <textarea class="form-control" id="address" rows="3"></textarea>
            </div>
            <div class="form-group">
              <div class="btn-group btn-group-justified">
                <div class="btn-group">
                  <button type="submit" class="btn btn-primary">修改</button>
                </div>
                <div class="btn-group">
                  <button type="button" class="btn btn-primary">重置</button>
                </div>
              </div>
            </div>
          </form>
        </div>
        <!--安全相关-->
        <div class="tab-pane fade in" id="safety">
          <form class="form-horizontal" id="updateUserLogin">
            <div class="form-group">
              <label for="username">登录名：</label>
              <input type="text" class="form-control" id="username"/>
            </div>
            <div class="form-group">
              <label for="password">新的密码：</label>
              <input type="password" class="form-control" id="password"/>
            </div>
            <div class="form-group">
              <label for="email">邮箱：</label>
              <input type="email" class="form-control" id="email"/>
            </div>
            <div class="form-group">
              <div class="btn-group btn-group-justified">
                <div class="btn-group">
                  <button type="submit" class="btn btn-primary">修改</button>
                </div>
                <div class="btn-group">
                  <button type="button" class="btn btn-primary">重置</button>
                </div>
              </div>
            </div>
          </form>
        </div>
        <!--下面的提示-->
        <div class="alert in fade hide alertPrototype">
          <button type="button" class="close" data-dismiss="alert"
                  aria-hidden="true">
            &times;
          </button>
          <span></span>
        </div>
      </div>
    </div>
  </div>
</main>
</body>
</html>

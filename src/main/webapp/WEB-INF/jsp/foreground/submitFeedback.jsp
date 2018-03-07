<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/3/7
  Time: 18:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>反馈</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <script src="${pageContext.request.contextPath}/statics/foreground/js/submitFeedback.js"></script>
</head>
<body>
<jsp:include page="commonHeader.jsp"/>
<main class="container">
  <h2 class="text-center text-primary">提交反馈</h2>
  <form id="submitFeedback">
    <div class="form-group">
      <label for="content">反馈内容</label>
      <textarea class="form-control" rows="8" id="content"></textarea>
    </div>
    <div class="btn-group btn-group-justified">
      <div class="btn-group">
        <button type="submit" class="btn btn-primary">提交</button>
      </div>
      <div class="btn-group">
        <button type="reset" class="btn btn-primary">重置</button>
      </div>
    </div>
  </form>
</main>
</body>
</html>

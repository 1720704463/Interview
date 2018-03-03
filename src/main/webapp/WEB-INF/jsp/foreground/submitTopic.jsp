<%--
  Created by IntelliJ IDEA.
  User: rxliuli
  Date: 2018/2/28
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang='zh-CN'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <meta http-equiv='x-ua-compatible' content='ie=edge'>
  <title>提交面试题</title>
  <!--引入 Bootstrap,jQuery 相关类库-->
  <link href="${pageContext.request.contextPath}/statics/commons/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="${pageContext.request.contextPath}/statics/commons/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/statics/commons/js/bootstrap.min.js"></script>

  <script src="${pageContext.request.contextPath}/statics/foreground/js/submitTopic.js"></script>
</head>
<body>
<%--引入公用的头部--%>
<jsp:include page="commonHeader.jsp"/>
<main class="container">
  <h2 class="text-center text-primary">提交面试题</h2>
  <form class="submitTopic">
    <div class="form-group">
      <label for="typeId">面试题目类型</label>
      <select class="form-control" id="typeId">
        <option value="393048438415167488">java</option>
        <option value="393048438415167489">SqlServer</option>
      </select>
    </div>
    <div class="form-group">
      <label for="title">标题</label>
      <textarea class="form-control" rows="5" id="title"></textarea>
    </div>
    <div class="form-group">
      <label for="answer">答案</label>
      <textarea class="form-control" rows="10" id="answer"></textarea>
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
  <br/>
  <div class="alert in fade alertPrototype" style="display: none;">
    <button type="button" class="close" data-dismiss="alert"
            aria-hidden="true">
      &times;
    </button>
    <span></span>
  </div>

</main>
</body>
</html>

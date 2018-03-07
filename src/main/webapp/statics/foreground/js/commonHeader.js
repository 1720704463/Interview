var rootContextPath = $("#rootContextPath").text();
/**
 * @author rxliuli
 */
$(function () {
  $.get({
    url: rootContextPath + "/user/userWhetherLogin",
    dataType: "json",
    success: function (json) {
      if (json.success) {
        //获取用户的 id 和头像路径
        var picture = json.data.picture;
        var $userAlreadyLogin = $("#userAlreadyLogin");
        var $userPictureImage = $userAlreadyLogin.find(".userPictureImage img");
        $userPictureImage.attr("src", rootContextPath + picture);
        $userAlreadyLogin.removeClass("hide")
      } else {
        $("#userNoLogin").removeClass("hide")
      }
    },
    error: function (data) {
      alert("网络错误: " + data)
    }
  })
});


/**
 * 取窗口可视范围的高度
 */
function getClientHeight() {
  var clientHeight;
  if (document.body.clientHeight && document.documentElement.clientHeight) {
    clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
  } else {
    clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
  }
  return clientHeight;
}

/**
 * 取窗口滚动条高度
 */
function getScrollTop() {
  var scrollTop = 0;
  if (document.documentElement && document.documentElement.scrollTop) {
    scrollTop = document.documentElement.scrollTop;
  } else if (document.body) {
    scrollTop = document.body.scrollTop;
  }
  return scrollTop;
}

/**
 * 取文档内容实际高度
 */
function getScrollHeight() {
  return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
}

/**
 * 显示一个提醒
 * @param f 对 alert 元素执行的操作
 * @param container 要将提醒添加到哪个容器中
 * @param closeTime 提醒自动关闭的时间
 * @return 进行操作的 $alert jQuery 对象
 */
function showAlert(f, container, closeTime) {
  //提示对象
  var $alert = $(
    "<div class='alert in fade'>\n" +
    "  <button type='button' class='close' data-dismiss='alert'\n" +
    "          aria-hidden='true'>\n" +
    "    &times;\n" +
    "  </button>\n" +
    "  <span></span>\n" +
    "</div>");
  //执行你需要进行的操作
  if (f !== undefined) {
    f($alert);
  }
  //装配到容器中
  if (container !== undefined) {
    $(container).append($alert);
  }
  //设定关闭时间
  if (closeTime !== undefined) {
    setTimeout(function () {
      $alert.alert("close");
    }, closeTime);
  }
  //返回 alert 对象
  return $alert;
}
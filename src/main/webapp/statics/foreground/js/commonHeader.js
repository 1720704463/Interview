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
        var id = json.data.id;
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

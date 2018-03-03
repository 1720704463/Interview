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
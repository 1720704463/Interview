/**
 * @author rxliuli
 */
$(function () {
  /**
   * 提交反馈
   */
  $("#submitFeedback").find(":submit").click(function () {
    //获取反馈内容
    var content = $("#content").val().trim();
    if (content === '') {
      showAlert(function ($alert) {
        $alert.addClass("alert-warning")
          .css("margin-top", "1rem")
          .find("span").html("你还没有填写反馈内容呢！")
      }, "main", 3000);
      return false;
    }

    $.post({
      url: "/user/submitFeedbackExecute",
      dataType: "json",
      data: {
        content: content
      },
      success: function (json) {
        showAlert(function ($alert) {
          if (json.success) {
            $alert.addClass("alert-success")
              .css("margin-top", "1rem")
              .find("span").html("反馈成功，即将跳转到首页！")
          } else {
            $alert.addClass("alert-warning")
              .css("margin-top", "1rem")
              .find("span").html(json.message)
          }
        }, "main", 3000);
        setTimeout(function () {
          open(rootContextPath + "/user/home", "_self");
        }, 3000)
      }
    });

    return false;
  })
});
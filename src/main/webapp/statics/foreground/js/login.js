/**
 * @author rxliuli
 */
$(function () {
  /**
   * 用户登陆.
   */
  $(".form-login button:submit").click(function () {
    //获得登陆名和密码
    var username = $("#username").val();
    var password = $("#password").val();
    var remember = $("#remember").is(":checked");

    //非空校验
    if (username.trim() === ''
      || password.trim() === '') {
      alert("用户名或密码为空!");
      return false;
    }

    //进行 ajax 验证
    $.post({
      url: "/user/loginExecute",
      dataType: "json",
      data: {
        username: username,
        password: password,
        remember: remember
      },
      success: function (json) {
        var success = json.success;
        if (success) {
          open("/user/home", "_self");
        } else {
          alert(json.message);
        }
      },
      error: function () {
        alert("网络错误啦！")
      }
    });
    //无论是否成功都不会提交表单(然而如果真的成功就会直接跳转到其他页面了 233333)
    return false;
  })
});
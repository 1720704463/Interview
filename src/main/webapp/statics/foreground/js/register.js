/**
 * @author rxliuli
 */
$(function () {
  //用户名改变时则进行检测
  var $username = $("#username");
  $username.on("input", function () {
    var username = $username.val().trim();
    if (username === "") {
      $username.next(" span").html("&nbsp;");
      return;
    }
    $.get({
      url: "/user/findByUsername",
      data: {
        username: username
      },
      dataType: "json",
      success: function (json) {
        if (json.success) {
          $username.next(" span").html("&nbsp;");
          $(".btnRegister").removeAttr("disabled");
        } else {
          $username.next(" span").html(json.message);
          $(".btnRegister").attr("disabled", "disabled");
        }
      }
    })
  });
  //邮箱改变时则进行检测
  var $email = $("#email");
  $email.on("input", function () {
    var email = $email.val().trim();
    if (email === "") {
      $email.next(" span").html("&nbsp;");
      return;
    }
    $.get({
      url: "/user/findByEmail",
      data: {
        email: email
      },
      dataType: "json",
      success: function (json) {
        if (json.success) {
          $email.next(" span").html("&nbsp;");
          $(".btnRegister").removeAttr("disabled");
        } else {
          $email.next(" span").html(json.message);
          $(".btnRegister").attr("disabled", "disabled");
        }
      }
    })
  });

  //真正执行用户注册
  $(".btnRegister").click(function () {
    $.post({
      url: "/user/registerExecute",
      data: {
        username: $username.val().trim(),
        password: $("#password").val().trim(),
        email: $email.val().trim()
      },
      dataType: "json",
      success: function (json) {
        if (json.success) {
          $(".alertRegister").fadeIn();
          setTimeout(function () {
            $(".alertRegister").fadeOut();
            open("/user/home", "_self")
          }, 3000);
        } else {
          alert("注册失败，请重新尝试，或联系管理员进行反馈！")
        }
      }
    });
    return false;
  })
});
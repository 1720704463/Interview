/**
 * @author rxliuli
 */
$(function () {
  var userLogin;
  var userInfo;

  /**
   * 创建用户详细信息的原型
   */
  function UserInfo(id, nickname, realname, picture, birthday, gender, address) {
    this.id = id;
    this.nickname = nickname;
    this.realname = realname;
    this.picture = picture;
    this.birthday = birthday;
    this.gender = gender;
    this.address = address;
  }

  /**
   * 创建用户登录信息的原型
   */
  function UserLogin(id, username, password, email) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.email = email;
  }

  /**
   * 获取所有的用户信息
   */
  $.get({
    url: "/user/getUserInfoDetail",
    dataType: "json",
    success: function (json) {
      if (json.success) {
        userLogin = json.data.userLogin;
        userInfo = json.data.userInfo;
        loadDataUserInfo();
        loadDataUserLogin();
      }
    }
  });

  /**
   * 加载用户信息
   */
  function loadDataUserInfo() {
    $("#nickname").val(userInfo.nickname);
    $("#realname").val(userInfo.realname);
    $("#oldPicture").attr("src", userInfo.picture);
    $("#birthday").val(userInfo.birthday.substr(0, 10));
    $("#gender").find("input[value=" + userInfo.gender + "]").prop("checked", "checked");
    $("#address").val(userInfo.address);
  }

  /**
   * 加载用户安全信息
   */
  function loadDataUserLogin() {
    $("#username").val(userLogin.username);
    $("#password").val(userLogin.password);
    $("#email").val(userLogin.email);
  }

  var $updateUserInfo = $("#updateUserInfo");
  /**
   * 修改用户的信息
   */
  $updateUserInfo.find("button[type=submit]").click(function () {
    //获取用户的更新的各种信息
    var nickname = $("#nickname").val().trim();
    var realname = $("#realname").val().trim();
    var newPicture = $("#newPicture").val().trim();
    var birthday = $("#birthday").val().trim();
    var gender = $("#gender").find("input[type=radio]:checked").val().trim();
    var address = $("#address").val().trim();
    var newUserInfo = new UserInfo(
      userInfo.id,
      nickname === '' ? null : nickname,
      realname === '' ? null : realname,
      newPicture === '' ? null : newPicture,
      birthday === '' ? null : birthday,
      gender === '' ? null : gender,
      address === '' ? null : address
    );
    $.post({
      url: rootContextPath + "/user/updateUserInfo",
      dataType: "json",
      data: {
        userInfoString: JSON.stringify(newUserInfo)
      },
      success: function (json) {
        showAlert(function ($alert) {
          if (json.success) {
            userInfo = json.data;
            $alert.addClass("alert-success")
              .find("span").html("更新用户信息成功！");
            loadDataUserInfo();
          } else {
            $alert.addClass("alert-danger")
              .find("span").html(json.message);
          }
        }, "main", 3000);
      }
    });

    return false;
  });

  /**
   * 重置用户信息
   */
  $updateUserInfo.find("button[type=button]").click(function () {
    loadDataUserInfo();
  });

  var $updateUserLogin = $("#updateUserLogin");
  /**
   * 修改用户的登录信息
   */
  $updateUserLogin.find("button[type=submit]").click(function () {
    var username = $("#username").val().trim();
    var password = $("#password").val().trim();
    var email = $("#email").val().trim();
    var newUserLogin = new UserLogin(
      userLogin.id,
      username === '' ? null : username,
      password === '' ? null : password,
      email === '' ? null : email
    );
    $.post({
      url: rootContextPath + "/user/updateUserLogin",
      dataType: "json",
      data: {
        userLoginString: JSON.stringify(newUserLogin)
      },
      success: function (json) {
        showAlert(function ($alert) {
          if (json.success) {
            userLogin = json.data;
            userLogin.password = null;
            $alert.addClass("alert-success")
              .find("span").html("更新用户信息成功！");
            loadDataUserLogin();
          } else {
            $alert.addClass("alert-danger")
              .find("span").html(json.message);
          }
        }, "main", 3000);
      }
    });

    return false;
  });


  /**
   * 重置用户的密码/邮箱
   */
  $updateUserLogin.find("button[type=button]").click(function () {
    loadDataUserLogin();
  });

  /**
   * 销毁账号
   */
  $("#removeUser").click(function () {
    var isAffirm = confirm("请问确实要删除用户所有的信息么？\n(警告：此操作不可恢复)");
    if (isAffirm) {
      $.post({
        url: "/user/removeUserAllInfo",
        dataType: "json",
        success: function (json) {
          var $alertPropertyClone = $(" main .alertPrototype").clone(true)
            .attr({
              class: "alert in fade alert"
            });
          if (json.success) {
            $alertPropertyClone.addClass("alert-success")
              .find("span").html("删除用户成功，即将跳转到首页！");
            setTimeout(function () {
              open(rootContextPath + "/user/home", "_self")
            }, 3000);
          } else {
            $alertPropertyClone.addClass("alert-success")
              .find("span").html(json.message);
          }
          //3s 后自动关闭
          setTimeout(function () {
            $alertPropertyClone.alert("close");
          }, 3000);
        }
      })
    }
  });

});
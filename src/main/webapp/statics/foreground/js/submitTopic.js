/**
 * @author rxliuli
 */

$(function () {
  /**
   * 提交新的面试题目
   */
  $(".submitTopic :submit").click(function () {
    var typeId = $("#typeId").val().trim();
    var title = $("#title").val().trim();
    var answer = $("#answer").val().trim();

    //判空
    if (title === '' || answer === '' || typeId === '') {
      var $alertPropertyClone = $(" main .alertPrototype").clone(true);
      $alertPropertyClone.removeClass("alertPrototype").addClass("alert-danger")
        .find(" span").attr("color", "red").text("面试题目不能存在空值！");
      $alertPropertyClone.fadeIn();
      $(" main").append($alertPropertyClone);
      setTimeout(function () {
        $alertPropertyClone.alert("close");
      }, 3000);
      return false;
    }

    //提交数据
    $.ajax({
      url: "/addTopicExecute",
      type: "post",
      data: {
        typeId: typeId,
        title: title,
        answer: answer
      },
      dataType: "json",
      success: function (json) {
        $(".submitTopic .form-control:gt(0)").val('');
        if (json.success) {
          var $alertPropertyClone = $(" main .alertPrototype").clone(true);
          $alertPropertyClone.removeClass("alertPrototype").addClass("alert-success")
            .find(" span").attr("color", "white").text("添加面试题目成功！");
          $alertPropertyClone.fadeIn();
          $(" main").append($alertPropertyClone);
          setTimeout(function () {
            $alertPropertyClone.alert("close");
          }, 3000);
        } else {
          var $alertPropertyClone = $(" main .alertPrototype").clone(true);
          $alertPropertyClone.removeClass("alertPrototype").addClass("alert-danger")
            .find(" span").attr("color", "red").text(json.message);
          $alertPropertyClone.fadeIn();
          $(" main").append($alertPropertyClone);
          setTimeout(function () {
            $alertPropertyClone.alert("close");
          }, 3000);
        }
      },
      error: function (data) {
        alert("发生了错误！" + data)
      }
    });

    return false;
  })
});
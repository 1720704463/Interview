/**
 * @author rxliuli
 */
$(function () {
  var examId;
  /**
   * 页面一加载就随机获取 20 道面试题目
   */
  $.get({
    url: "/user/addExamUserTest",
    dataType: "json",
    data: {
      topicNumber: 20
    },
    success: function (json) {
      if (json.success) {
        var $idList = $("#idList");
        var $topicList = $("#topicList");
        examId = json.data.examId;
        $(json.data.topicList).each(function (index, topic) {
          //选项卡
          var $idClone = $idList.find(".idProtoType").clone(true);
          var topicIndex = index + 1;
          $idClone
            .attr({class: "id"})
            .find(" a")
            .attr("href", "#" + topic.id)
            .html("第 " + (topicIndex >= 10 ? topicIndex : ("&nbsp;" + topicIndex + "&nbsp;")) + " 题");
          $idClone.fadeIn();
          $idList.append($idClone);
          //答案输入框
          var $topicPrototypeClone = $topicList.find(".topicPrototype").clone();
          $topicPrototypeClone.attr({
            class: "tab-pane fade in topic",
            id: topic.id
          });
          $topicPrototypeClone.find(".titlePrototype").attr({
            class: "title"
          }).text(topic.title);
          $topicPrototypeClone.find(".answerPrototype").attr({
            class: "answer form-control"
          });
          $topicPrototypeClone.fadeIn();
          $topicList.append($topicPrototypeClone);
        });
        //默认显示第一个
        $idList.find(".id:eq(0)").addClass("active");
        $topicList.find(".topic:eq(0)").addClass("active");
      }
    },
    error: function (json) {
      alert("发生了一些错误: " + json)
    }
  });

  $(".submitUserTest :submit").click(function () {
    /**
     * 创建一个原型
     */
    function Topic(id, answer) {
      this.id = id;
      this.answer = answer;
    }

    //获取所有的题目完成情况
    var topicList = [];
    $("#topicList").find(".topic").each(function (index, topicDOM) {
      var $topic = $(topicDOM);
      var id = $topic.attr("id");
      var answer = $topic.find(".answer").val();
      topicList[index] = new Topic(id, answer);
    });

    $.post({
      url: "/user/submitUserTest",
      dataType: "json",
      data: {
        topicListString: JSON.stringify(topicList),
        examId: examId
      },
      success: function (json) {
        //判断是否提交成功
        if (json.success) {
          $("#prompt")
            .attr({
              class: "alert alert-success fade in"
            })
            .fadeIn()
            .find(" span").text("提交考试成功,即将跳转到首页!");
          //3s 后跳转至首页
          setTimeout(function () {
            open("/user/home", "_self")
          }, 3000);
        } else {
          $("#prompt")
            .attr({
              class: "alert alert-danger fade in"
            })
            .fadeIn()
            .find(" span").text("提交考试失败,请重试!");
        }
        //2s 后隐藏
        setTimeout(function () {
          $("#prompt").fadeOut();
        }, 2000)
      },
      error: function (json) {
        alert(json)
      }
    });
    return false;
  })

});
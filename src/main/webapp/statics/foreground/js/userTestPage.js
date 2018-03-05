/**
 * @author rxliuli
 */
$(function () {
  //当前考试的信息
  var exam;

  /**
   * 页面一加载就随机获取 20 道面试题目
   */
  $.get({
    url: rootContextPath + "/user/addExamUserTest",
    dataType: "json",
    data: {
      topicNumber: 20
    },
    success: function (json) {
      if (json.success) {
        var $idList = $("#idList");
        var $topicList = $("#topicList");
        exam = json.data.exam;
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

        //设置一下用户的考试时间提醒
        castTestRemainingTime();
        setInterval(function () {
          castTestRemainingTime();
        }, 1000);

        /**
         * 计算剩余的考试时间
         */
        function castTestRemainingTime() {
          var nowDate = new Date();
          var endDate = new Date(Date.parse(exam.endTime));
          var differenceDate = new Date(endDate.getTime() - nowDate.getTime());
          $("#testRemainingTime").text(
            "考试时间还剩余: "
            + differenceDate.getMinutes()
            + " 分 "
            + differenceDate.getSeconds()
            + " 秒 "
          );
        }
      }
    },
    error: function (json) {
      alert("发生了一些错误: " + json)
    }
  });

  /**
   * 每填写一个面试题目就改变题目选项卡的颜色进行标识
   */
  $("body").on("input", ".answer", function () {
    answerChange.call(this);
  });

  /**
   * 答案改变时进行判断并对按钮进行标识
   */
  function answerChange() {
    var activeIndex = $(".id.active").index() - 1;
    //rxliuliError: 这里的下标貌似有些问题?
    if ($("#topicList").find(".answer").eq(activeIndex).val().trim() === '') {
      $("#idList").find(".id").eq(activeIndex).removeClass("bg-info")
    } else {
      $("#idList").find(".id").eq(activeIndex).addClass("bg-info")
    }
  }

  /**
   * 点击清空就清空当前输入框的值
   */
  $(".submitUserTest :button").click(function () {
    var activeIndex = $(".id.active").index() - 1;
    $("#topicList").find(".answer").eq(activeIndex).val('');
    answerChange();
  });

  /**
   * 用户点击提交按钮
   */
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
      url: rootContextPath + "/user/submitUserTest",
      dataType: "json",
      data: {
        topicListString: JSON.stringify(topicList),
        examId: exam.id
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
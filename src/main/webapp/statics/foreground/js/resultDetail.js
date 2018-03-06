/**
 * @author rxliuli
 */
$(function () {
  //获取当前页面要加载的考试编号
  var resultId = window.location.pathname.substr(14);

  /**
   * 根据考试编号获取考试题目的对错,涉及到 Exam,Result,ExamTopic,Topic 4 个实体类
   */
  $.get({
    url: rootContextPath + "/getExamTopicByResultId",
    dataType: "json",
    data: {
      resultId: resultId
    },
    success: function (json) {
      if (json.success) {
        //加载数据
        var $idList = $("#idList");
        var $topicList = $("#topicList");
        $(json.data).each(function (index, map) {
          var topic = map.topic;
          var examTopic = map.examTopic;
          var topicIndex = index + 1;
          //克隆一个 id(题目的序号)
          var $idClone = $idList.find(".idProtoType").clone(true);
          $idClone.attr("class", "id")
            .find("a").attr("href", "#" + topic.id).html("第 " + (topicIndex >= 10 ? topicIndex : ("&nbsp;" + topicIndex + "&nbsp;")) + " 题");
          $idList.append($idClone);
          //克隆一个答案
          var $topicClone = $topicList.find(".topicPrototype").clone(true);
          $topicClone.attr({
            class: "tab-pane fade in topic",
            id: topic.id
          });
          $topicClone.find(".title").text("面试题目：" + topic.title);
          $topicClone.find(".userAnswer").html(
            examTopic == null ? "<span class='text-danger'>你没有作答！</span>" : examTopic.content
          );
          $topicClone.find(".answer").text(topic.answer);
          $topicList.append($topicClone);
        });
        //将第一个设置为默认显示
        $idList.find(".id:eq(0)").addClass("active");
        $topicList.find(".topic:eq(0)").addClass("active");
      }
    }
  })

});
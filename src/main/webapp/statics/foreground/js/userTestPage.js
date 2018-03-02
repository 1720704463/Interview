/**
 * @author rxliuli
 */
$(function () {
  /**
   * 页面一加载就随机获取 20 道面试题目
   */
  $.get({
    url: "getTopicRandom",
    dataType: "json",
    data: {
      topicNumber: 20
    },
    success: function (json) {
      if (json.success) {
        var $idList = $("#idList");
        var $topicList = $("#topicList");
        $(json.data).each(function (index, topic) {
          //选项卡
          var $idClone = $idList.find(".idProtoType").clone(true);
          $idClone
            .attr({class: "id"})
            .find(" a")
            .attr("href", "#" + topic.id)
            .text("第 " + (index + 1) + " 题");
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

    var topic = new Topic("1", "答案");
    console.log(topic);
    $.post({
      url: "",
      dataType: "json",
      data: {},
      success: function (json) {

      }
    });
    return false;
  })

});
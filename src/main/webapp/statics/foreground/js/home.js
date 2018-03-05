/**
 * @author rxliuli
 */
$(function () {
  //第几页
  var pageIndex = 1;
  //一页显示的学生信息数量
  var pageSize = 10;
  //总页数
  var pages = 0;

  /**
   * 页数改变时修改数据
   */
  function changePage() {
    $.ajax({
      //请求的路径
      url: rootContextPath + "/getTopicListByParam",
      //请求的类型
      type: "post",
      //返回数据的类型
      dataType: "json",
      //参数
      data: {
        pageIndex: pageIndex,
        pageSize: pageSize,
        searchTopicTitle: $("#searchTopicTitle").val()
      },
      //成功后的回调函数
      success: function (json) {
        //判断是否成功
        if (json.success) {
          loadData(json.data)
        } else {
          alert(json.message);
          location.reload();
        }
      },
      //失败后的回调函数
      error: function () {
        alert("网络错误啦！")
      }
    })
  }

  /**
   * 加载数据
   * @param map 用已加载的数据(包含分页的所有信息)
   */
  function loadData(map) {
    //清除旧的考试信息并加载新的
    // $(".topicList .topic").remove();
    var topicPage = map.topicPage;
    var topicTypeList = map.topicTypeList;
    $(topicPage.records).each(function (index, topic) {
      //克隆原型问题
      var $topicClone = $(".topicList .topicProperty")
        .clone(true)
        .removeClass()
        .addClass("panel panel-default topic");
      //给克隆的原型副本赋值
      //题目类型
      $($topicClone).find(".typeTitle").text(topicTypeList[index].title).attr("typeId", topic.typeId);
      //题目标题
      $($topicClone).find(".topicTitle").text(topic.title);
      //题目答案隐藏面板的 id
      $($topicClone).find(".panel-collapse.collapse").attr("id", topic.id);
      //题目的答案
      $($topicClone).find(".referenceAnswer").text(topic.answer);
      //最后修改时间
      $($topicClone).find(".updateTime").text(topic.updateTime);
      //切换答案是否显示的按钮
      $($topicClone).find(".btnReferenceAnswerToggle").attr("data-target", "#" + topic.id);
      $($topicClone).find(".updateTopic").attr("topicId", topic.id);
      $($topicClone).find(".deleteTopic").attr("topicId", topic.id);

      $(".topicList").append($topicClone);
    });
    //加载页数之类
    pageIndex = topicPage.current;
    pages = topicPage.pages;
    $(".pageIndex").text(pageIndex + " / " + pages)
  }

  /**
   * 实时搜索功能.
   */
  $("#searchTopicTitle").on("input", function () {
    pageIndex = 1;
    $(".topicList .topic").remove();
    changePage();
  });

  //默认加载第一页
  changePage();

  $(window).scroll(function () {
    var height = getClientHeight();
    var theight = getScrollTop();
    var rheight = getScrollHeight();
    var bheight = rheight - theight - height;

    //如果快到底部了就进行判断
    if (bheight < 200) {
      if (pageIndex < pageSize) {
        pageIndex++;
        changePage();
        $("#prompt").fadeIn().find(" span").text("正在加载中....");
      } else {
        $("#prompt").fadeIn().find(" span").text("已经到最后一页了");
      }
    } else {
      $("#prompt").fadeOut();
    }
  })


});

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
    $.get({
      url: rootContextPath + "/getResultList",
      dataType: "json",
      data: {
        pageIndex: pageIndex,
        pageSize: pageSize
      },
      success: function (json) {
        if (json.success) {
          loadData(json.data);
        }
      }
    })
  }

  /**
   * 加载数据
   */
  function loadData(map) {
    var resultPage = map.resultPage;
    var examList = map.examList;
    $(examList).each(function (index, exam) {
      var $resultList = $("#resultList");
      var $resultClone = $resultList.find(".resultPrototype").clone(true);
      $resultClone.attr({
        class: "panel panel-primary result"
      });
      $resultClone.find(".examTitle").text(exam.title);
      $resultClone.find(".examTime").text(exam.startTime + " - " + exam.endTime);
      //设置查看详情
      $resultClone.find(".seeDetail").attr({
        href:
        rootContextPath
        + "/resultDetail/"
        + resultPage.records[index].id
      });

      $resultList.append($resultClone)
    });
    //加载页数之类
    pageIndex = resultPage.current;
    pages = resultPage.pages;
  }

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
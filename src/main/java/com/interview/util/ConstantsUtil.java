package com.interview.util;

/**
 * 静态状态类
 *
 * @author wuhaiyuan
 */
public final class ConstantsUtil {
  /**
   * 保存用户 session 的字段名.
   */
  public static final String USER_SESSION = "userSession";

  /**
   * 保存管理员 session 的字段名.
   */
  public static final String ADMIN_SESSION = "adminSession";

  /**
   * 日期格式化模式字符串.
   * 因为 html 的默认日期格式是 yyyy-MM-ddThh:mm
   */
  public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd hh:mm:ss";
  /**
   * 添加考试时题目数量的最小值.
   */
  public static final int TOPIC_MIN_NUMBER = 10;
  /**
   * 添加考试时题目数量的最大值.
   */
  public static final int TOPIC_MAX_NUMBER = 60;
  /**
   * 首页查询题目的默认数量.
   */
  public static final int TOPIC_NUMBER = 50;
  /**
   * 头像的最大大小
   */
  public static final int FILE_MAX_SIZE = 5_000_000;

  private ConstantsUtil() {
  }

}

package com.interview.util;

import org.apache.commons.lang3.builder.EqualsBuilder;

/**
 * apache common lang3 的增强工具
 * <p>
 * 依赖：
 * apache common lang3 的工具包
 *
 * @author rxliuli
 */
public class Lang3Util {
  /**
   * 一个连续判断是否相等的单例 EqualsBuilder 对象
   */
  private static final EqualsBuilder EQUALS_BUILD_INSTANCE = new EqualsBuilder();

  /**
   * 获取一个连续判断的 EqualsBuilder 对象
   *
   * @return 一个连续判断的 EqualsBuilder 对象
   */
  public static EqualsBuilder getEqualsBuildInstance() {
    EQUALS_BUILD_INSTANCE.reset();
    return EQUALS_BUILD_INSTANCE;
  }
}

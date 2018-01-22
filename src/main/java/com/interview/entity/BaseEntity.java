package com.interview.entity;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.io.Serializable;

/**
 * 实体类的基类
 * 使用 apache commons lang3 类库重写了一些重要的方法
 * 1.toString() 方法：现在，直接输出所有的实体类都会输出有意义的值了
 * 2.hashCode() 方法：重写 toString() 必须要重写的方法，代表对象的 [哈希值]，
 * 两个不同的对象 hash 可能相同（概率非常小），然而两个 hash 不同的对象一定是不同的！
 * 3.equals 方法：现在，可以使用 equals() 方法比较两个对象的相等性了，引用相同在大部分时候都不是我们需要的
 * 如有必要，请使用 == 进行比较对象的引用是否相等
 *
 * @author rxliuli
 */
public class BaseEntity implements Serializable {
  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }

  @Override
  public int hashCode() {
    return HashCodeBuilder.reflectionHashCode(this);
  }

  @Override
  public boolean equals(Object obj) {
    return EqualsBuilder.reflectionEquals(this, obj);
  }

  @Override
  protected Object clone() throws CloneNotSupportedException {
    return ObjectUtils.clone(this);
  }
}

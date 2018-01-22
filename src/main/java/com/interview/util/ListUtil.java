package com.interview.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * list 工具类'
 * 为了解决 list 的添加元素问题
 *
 * @author rxliuli
 */
public final class ListUtil<T> {
  /**
   * list 集合的默认初始大小
   */
  private static final int INITIAL_CAPACITY = 4;

  private List<T> list;


  /**
   * 获取一个含有空的 List<T> 的 ListUtil<T> 对象
   * <p>
   * 创建一个含有空的 List<T> 的 ListUtil<T> 对象
   */
  public ListUtil() {
    this.list = new ArrayList<>(INITIAL_CAPACITY);
  }

  /**
   * 获取一个含有空的 List<T> 的 ListUtil<T> 对象
   * <p>
   * 根据传入的 list 参数创建一个 ListUtil<T> 对象
   *
   * @param list 初始化的集合
   */
  public ListUtil(List<T> list) {
    this.list = list;
  }

  public ListUtil<T> add(T t) {
    this.list.add(t);
    return this;
  }

  public ListUtil<T> add(T... ts) {
    this.list.addAll(Arrays.asList(ts));
    return this;
  }

  public ListUtil<T> remove(T t) {
    this.list.remove(t);
    return this;
  }

  public ListUtil<T> remove(T... ts) {
    this.list.removeAll(Arrays.asList(ts));
    return this;
  }

  /**
   * 获取最终的 List<T> 对象
   *
   * @return 最终产生的 List<T> 对象
   */
  public List<T> getList() {
    return list;
  }
}

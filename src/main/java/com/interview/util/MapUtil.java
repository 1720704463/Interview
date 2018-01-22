package com.interview.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Map 工具类'
 * 为了解决 Map
 *
 * @author rxliuli
 */
public final class MapUtil<K, V> {
  /**
   * Map 集合的默认初始大小
   */
  private static final int INITIAL_CAPACITY = 4;

  private Map<K, V> map;

  /**
   * 获取一个含有空的 Map<K,V> 的 MapUtil<K,V> 对象
   * <p>
   * 创建一个含有空的 Map<K,V> 的 MapUtil<K,V> 对象
   */
  public MapUtil() {
    this.map = new HashMap<>(INITIAL_CAPACITY);
  }

  /**
   * 获取一个含有空的 Map<K,V> 的 MapUtil<K,V> 对象
   * <p>
   * 根据传入的 map 参数创建一个 MapUtil<K,V> 对象
   *
   * @param map 初始化的集合
   */
  public MapUtil(Map<K, V> map) {
    this.map = map;
  }

  /**
   * 添加一个键值对
   *
   * @param entry 键值对对象
   * @return this
   */
  public MapUtil<K, V> add(Map.Entry<K, V> entry) {
    map.put(entry.getKey(), entry.getValue());
    return this;
  }

  /**
   * 添加一个键值对
   *
   * @param k 键值对对象
   * @return this
   */
  public MapUtil<K, V> remove(K k) {
    map.remove(k);
    return this;
  }

  /**
   * 添加一堆新的键值对
   *
   * @param k 键
   * @param v 值
   * @return this
   */
  public MapUtil<K, V> add(K k, V v) {
    map.put(k, v);
    return this;
  }

  /**
   * 获取最终的 Map<K,V> 对象
   *
   * @return 最终产生的 Map<K,V> 对象
   */
  public Map<K, V> getMap() {
    return map;
  }


}

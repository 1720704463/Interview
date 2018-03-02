package com.interview.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.LongSerializationPolicy;
import com.google.gson.reflect.TypeToken;

import java.util.List;
import java.util.Map;

/**
 * Gson 简单封装的工具类.
 * <p>
 * 依赖：
 * jdk 1.8
 * GSON json 转换库
 *
 * @author rxliuli
 */
public final class GsonUtil {
  /**
   * 定义一个用于输出格式(适合人类阅读)的单例 GSON 对象.
   */
  public static final Gson GSON_OUTPUT = new GsonBuilder()
    //设置日期格式.
    .setDateFormat("yyyy-MM-dd hh:mm:ss")
    //设置 Long 类型自动转换成 String 类型
    .setLongSerializationPolicy(LongSerializationPolicy.STRING)
    //设置将 java 对象转换成可读性好的 json 字符串.
    .setPrettyPrinting()
    //设置不要忽略默认值为 null 的对象字段.
    .serializeNulls()
    //执行创建 Gson 转换对象
    .create();

  /**
   * 定义一个私有的单例 GSON 对象(降低性能开销)，用于处理简单的 json 序列化和反序列化.
   */
  private static final Gson GSON = new GsonBuilder()
    .setDateFormat("yyyy-MM-dd hh:mm:ss")
    .setLongSerializationPolicy(LongSerializationPolicy.STRING)
    .create();

  /**
   * 私有化 GsonUtil，禁止 new 出对象.
   */
  private GsonUtil() {
  }

  /**
   * 将某个对象转换为 json 格式的字符串.
   *
   * @param object 转换的对象
   * @return 转换得到的 json 字符串
   */
  public static String gsonToString(Object object) {
    return GSON.toJson(object);
  }

  /**
   * 将 json 格式的字符串转换为 java 的对象.
   *
   * @param json json 格式的字符串
   * @param cls  要转换的类型
   * @param <T>  泛型参数
   * @return 转换得到的对象
   */
  public static <T> T gsonToBean(String json, Class<T> cls) {
    return GSON.fromJson(json, cls);
  }

  /**
   * 将 json 格式的字符串转换为 {@code List<T>} 泛型集合.
   *
   * @param json json 格式的字符串
   * @param <T>  泛型参数
   * @return 转换得到的 {@code List<T>} 泛型集合
   */
  public static <T> List<T> gsonToList(String json, TypeToken<List<T>> typeToken) {
    return GSON.fromJson(json, typeToken.getType());
  }

  /**
   * 将 json 格式的字符串转换为 {@code List<Map<String, T>>} 泛型集合.
   *
   * @param json json 格式的字符串
   * @param <T>  泛型参数
   * @return 转换得到的 {@code List<Map<String, T>>} 泛型集合
   */
  public static <T> List<Map<String, T>> gsonToMapList(String json, TypeToken<List<Map<String, T>>> typeToken) {
    return GSON.fromJson(json, typeToken.getType());
  }

  /**
   * 将 json 格式的字符串转换为 {@code Map<String, T>} 泛型集合.
   *
   * @param json json 格式的字符串
   * @param <T>  泛型参数
   * @return 转换得到的 {@code Map<String, T>} 泛型集合
   */
  public static <T> Map<String, T> gsonToMap(String json, TypeToken<Map<String, T>> typeToken) {
    return GSON.fromJson(json, typeToken.getType());
  }
}

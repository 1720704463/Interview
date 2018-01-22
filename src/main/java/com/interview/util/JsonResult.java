package com.interview.util;

import java.io.Serializable;

/**
 * Json 数据通用返回结果类.
 * 依赖：
 * jdk 1.5+
 *
 * @param <T> 泛型类型
 * @author rxliuli
 */
public final class JsonResult<T> implements Serializable {
  /**
   * ajax 发送的 json 请求的状态.
   * false 代表失败，true 代表成功，默认为 false
   */
  private Boolean success;
  /**
   * json 返回的一些消息，用得非常少.
   * 默认为 null，在使用 Gson 转换时默认会忽略
   */
  private String message;
  /**
   * 真正需要返回 java 对象/集合数据.
   * 常见的类型是 Object 和 {@code List<T>}泛型集合.
   * 注：
   * 避免将 java 对象转换得到的 json 字符串为其赋值，而是直接将 java 对象赋值给 data
   * (因为 gson 可以使用嵌套泛型，并且能够序列化/反序列化，所以没必要进行两次转换).
   * 默认为 null，在使用 Gson 转换时默认会忽略
   */
  private T data;

  /**
   * 全字段构造函数.
   *
   * @param success 状态
   * @param message 消息
   * @param data    java 对象/集合数据
   */
  private JsonResult(Boolean success, String message, T data) {
    this.success = success;
    this.message = message;
    this.data = data;
  }

  /**
   * ajax 发送的 json 请求成功时的默认静态工厂.
   * ajax 发送的 json 请求成功是一个很常见的场景，所以这个静态工厂为 success, message 提供默认值(true, null).
   *
   * @param data java 对象/集合数据
   * @return 成功的 JsonResult<T> 对象
   */
  public static <T> JsonResult<T> getSuccess(T data) {
    return new JsonResult<>(true, null, data);
  }

  /**
   * ajax 发送的 json 请求失败时的默认静态工厂.
   * 一般而言 ajax 发送的 json 请求失败时，提供一些消息是极好的(例如错误码)，所以这个静态工厂为 success, data 提供默认值(false, null)
   *
   * @param message 失败的消息
   * @return 失败的 JsonResult<T> 对象
   */
  public static <T> JsonResult<T> getError(String message) {
    return new JsonResult<>(false, message, null);
  }

  /**
   * 全功能的静态工厂.
   *
   * @param success ajax 请求是否成功
   * @param message 想要返回的消息
   * @param data    需要返回的数据(json/xml/html)
   * @return 新的 JsonResult<T> 对象
   */
  public static <T> JsonResult<T> getInstance(Boolean success, String message, T data) {
    return new JsonResult<>(success, message, data);
  }

  public Boolean isSuccess() {
    return success;
  }

  public void setSuccess(Boolean success) {
    this.success = success;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public T getData() {
    return data;
  }

  public void setData(T data) {
    this.data = data;
  }
}

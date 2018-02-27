package com.interview.conf;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.LongSerializationPolicy;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.GsonHttpMessageConverter;

/**
 * Gson 转换时的一些问题，手动配置一下转换的对象.
 *
 * @author rxliuli
 */
@Configuration
public class GsonMessageConfig extends GsonHttpMessageConverter {
  /**
   * 项目中转换 json 默认使用的 Gson 对象.
   */
  private static final Gson DEFAULT_GSON = new GsonBuilder()
    //null 也序列化
    .serializeNulls()
    //时间转化为特定格式 yyyy-MM-dd HH:mm:ss
    .setDateFormat("yyyy-MM-dd hh:mm:ss")
    //设置 Long 类型自动转换成 String 类型
    .setLongSerializationPolicy(LongSerializationPolicy.STRING)
    //执行创建 Gson 转换对象
    .create();

  @Override
  public void setGson(Gson gson) {
    super.setGson(
      DEFAULT_GSON
    );
  }
}

package com.interivew.util;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

/**
 * 文件上传的工具类
 * 简化 MultipartFile 单个文件上传的问题
 * <p>
 * 依赖：
 * JsonResult 工具类
 * apache common log4j 日志类库
 * apache common commons-fileupload 文件上传类库
 *
 * @author rxliuli
 */
public final class FileUploadUtil {
  /**
   * 日志记录对象
   */
  private static Logger logger = Logger.getLogger(FileUploadUtil.class);

  /**
   * 要进行上传的单个文件(必须)
   */
  private MultipartFile attach;
  /**
   * HttpServletRequest 请求对象
   */
  private HttpServletRequest request;
  /**
   * 要限定的文件后缀名
   */
  private String[] suffixs;
  /**
   * 上传文件的最大大小(byte 为单位,1 MB = 1024 * 1024 byte )
   */
  private Integer fileMaxSize;
  /**
   * 上传文件的路径,如果不存在会自动创建(必须)
   */
  private String path;
  /**
   * 上传文件的名字(必须)
   */
  private String fileName;

  private FileUploadUtil() {
  }

  /**
   * 设置基本必须的参数进行文件的上传
   *
   * @param attach   要进行上传的单个文件(必须)
   * @param path     上传文件的路径,如果不存在会自动创建(必须)
   * @param fileName 上传文件的名字(必须)
   * @return 上传文件工具类的实例
   */
  public static FileUploadUtil getInstance(MultipartFile attach, String path, String fileName) {
    return new FileUploadUtil()
      .setAttach(attach)
      .setPath(path)
      .setFileName(fileName);
  }

  /**
   * 上传文件的全功能方法
   *
   * @return 是否添加成功
   */
  public JsonResult<String> fileUpload() {
    //判断上传的文件是否为空
    if (attach.isEmpty()) {
      return JsonResult.getError("上传的文件是空的！");
    }
    //获取文件上传的 url，如果 request 请求对象为空就不获取
    if (request != null) {
      String pathTemp = request.getRequestURI();
      logger.info("uploadFile pathTemp ====================> " + pathTemp);
    }
    //原文件名
    String oldFileName = attach.getOriginalFilename();
    logger.info("uploadFile oldFileName =============> " + oldFileName);
    //原文件的后缀
    String suffix = FilenameUtils.getExtension(oldFileName);
    logger.debug("uploadFile prefix ====================> " + suffix);
    //获取上传文件的大小
    logger.debug("uploadFile size ====================> " + attach.getSize());
    //上传文件大小不能超过 5MB
    if (fileMaxSize != null && attach.getSize() > fileMaxSize) {
      final int byteToMB = 1024 * 1024;
      return JsonResult.getError(" * 上传大小不得超过 " + (fileMaxSize / byteToMB) + "MB");
    }

    //判断文件后缀名是否合法
    if (suffixs != null && !StringUtils.containsAny(suffix, suffixs)) {
      return JsonResult.getError("* 上传图片格式不正确！");
    }

    logger.debug("new fileName =========== " + attach.getName());
    File targetFile = new File(path, fileName);
    //判断文件存放路径是否存在，如果不存在就创建(递归式)
    if (!targetFile.exists()) {
      boolean mkdirs = targetFile.mkdirs();
      logger.info("文件夹创建是否成功了呢？============>" + mkdirs);
      if (!mkdirs) {
        return JsonResult.getError("文件夹创建失败！");
      }
    }
    //保存
    try {
      System.out.println("前" + targetFile);
      attach.transferTo(targetFile);
      System.out.println("后" + targetFile);
    } catch (Exception e) {
      logger.info(e.getMessage());
      return JsonResult.getError(" * 上传失败！");
    }
    //获取文件存放的完全路径名
    String idPicPath = path + File.separator + fileName;
    logger.info("文件上传成功过！文件的保存路径是 ============> " + idPicPath);
    return JsonResult.getSuccess(idPicPath);
  }

  public FileUploadUtil setAttach(MultipartFile attach) {
    this.attach = attach;
    return this;
  }

  public FileUploadUtil setRequest(HttpServletRequest request) {
    this.request = request;
    return this;
  }

  public FileUploadUtil setSuffixs(String... suffixs) {
    this.suffixs = suffixs;
    return this;
  }

  public FileUploadUtil setFileMaxSize(Integer fileMaxSize) {
    this.fileMaxSize = fileMaxSize;
    return this;
  }

  public FileUploadUtil setPath(String path) {
    this.path = path;
    return this;
  }

  public FileUploadUtil setFileName(String fileName) {
    this.fileName = fileName;
    return this;
  }

}

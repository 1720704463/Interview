package com.interview.aop;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

import java.util.ArrayList;
import java.util.Optional;

/**
 * 业务层的 AOP 增强
 *
 * @author rxliuli
 */
@Aspect
public class ServiceAop {
  /**
   * log4j 的 一个 logger 日志对象
   */
  private static final Log logger = LogFactory.getLog(ServiceAop.class.getName());

  /**
   * 定义查询数量的切点
   */
  @Pointcut("execution(public int com.interview.service..*.*(..))")
  public void countPointcut() {
  }

  /**
   * 查询数量的 AOP 增强
   */
  @Around("countPointcut()")
  public Object countAround(ProceedingJoinPoint proceedingJoinPoint) {
    Object resultValue;
    try {
      //执行方法获取返回值
      resultValue = proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      resultValue = -1;
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
    }
    return resultValue;
  }

  /**
   * 定义增删改的切点
   */
  @Pointcut("execution(public boolean com.interview.service..*.*(..))")
  public void updatePointcut() {
  }

  /**
   * 增删改的 AOP 增强
   */
  @Around("updatePointcut()")
  public Object updateAround(ProceedingJoinPoint proceedingJoinPoint) {
    Object resultValue;
    try {
      //执行方法获取返回值
      resultValue = proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      resultValue = false;
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
    }
    return resultValue;
  }

  /**
   * 定义查询列表的切点
   */
  @Pointcut("execution(public java.util.List com.interview.service..*.*(..))")
  public void listPointcut() {
  }

  /**
   * 查询列表的 AOP 增强
   */
  @Around("listPointcut()")
  public Object listAround(ProceedingJoinPoint proceedingJoinPoint) {
    Object resultValue;
    try {
      //执行方法获取返回值
      resultValue = proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      resultValue = new ArrayList<>();
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
    }
    return resultValue;
  }

  /**
   * 定义查询对象的切点
   */
  @Pointcut("execution(public com.interview.entity.* com.interview.service..*.*(..))")
  public void findPointcut() {
  }

  /**
   * 查询对象的 AOP 增强
   */
  @Around("findPointcut()")
  public Object findAround(ProceedingJoinPoint proceedingJoinPoint) {
    Object resultValue;
    try {
      //执行方法获取返回值
      resultValue = proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      resultValue = null;
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
    }
    return resultValue;
  }

  /**
   * 定义查询对象的切点
   */
  @Pointcut("execution(public java.util.Optional com.interview.service..*.*(..))")
  public void optionalPointcut() {
  }

  /**
   * 查询对象的 AOP 增强
   */
  @Around("optionalPointcut()")
  public Object optionalAround(ProceedingJoinPoint proceedingJoinPoint) {
    Object resultValue;
    try {
      //执行方法获取返回值
      resultValue = proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      resultValue = Optional.empty();
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
    }
    return resultValue;
  }

}

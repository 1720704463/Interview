package com.interview.aop;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * mybatis plus 的业务层的切面
 *
 * @author rxliuli
 */
@Aspect
public class MPServiceAspect {
  /**
   * log4j 的 一个 logger 日志对象
   */
  private static final Log logger = LogFactory.getLog(ServiceAop.class);

  /**
   * 定义增删改的切点
   */
  @Pointcut("execution(boolean com.baomidou.mybatisplus.service.impl.ServiceImpl.*(..))")
  public void updatePointcut() {
  }

  /**
   * 增删改的 AOP 增强
   */
  @Around("updatePointcut()")
  public Object updateAround(ProceedingJoinPoint proceedingJoinPoint) {
    try {
      //执行方法获取返回值
      return proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
      return false;
    }
  }

  /**
   * 定义查询列表的切点
   */
  @Pointcut("execution(java.util.List com.baomidou.mybatisplus.service.impl.ServiceImpl.*(..))")
  public void listPointcut() {
  }

  /**
   * 查询列表的 AOP 增强
   */
  @Around("listPointcut()")
  public Object listAround(ProceedingJoinPoint proceedingJoinPoint) {
    return using(proceedingJoinPoint, new ArrayList<>());
  }

  /**
   * 定义查询 Map 的切点
   */
  @Pointcut("execution(java.util.List com.baomidou.mybatisplus.service.impl.ServiceImpl.*(..))")
  public void mapPointcut() {
  }

  /**
   * 查询 Map 的 AOP 增强
   */
  @Around("mapPointcut()")
  public Object mapAround(ProceedingJoinPoint proceedingJoinPoint) {
    return using(proceedingJoinPoint, new HashMap<>(2));
  }

  /**
   * 定义其他的切点
   */
  @Pointcut("execution(Object com.baomidou.mybatisplus.service.impl.ServiceImpl.*(..))")
  public void otherPointcut() {
  }

  /**
   * 查询其他的 AOP 增强
   */
  @Around("otherPointcut()")
  public Object otherAround(ProceedingJoinPoint proceedingJoinPoint) {
    return using(proceedingJoinPoint, null);
  }


  /**
   * 一个封装 AOP 的封装方法
   * 简化 AOP 增强的代码
   *
   * @param proceedingJoinPoint   切入方法的信息
   * @param throwableReturnObject 发生异常时的返回值对象
   * @return 正常执行时返回切入方法的返回值, 否则返回传入的异常返回值对象
   */
  private Object using(ProceedingJoinPoint proceedingJoinPoint, Object throwableReturnObject) {
    try {
      //执行方法获取返回值
      return proceedingJoinPoint.proceed();
    } catch (Throwable throwable) {
      //想获取类，方法
      Object target = proceedingJoinPoint.getTarget();
      String name = proceedingJoinPoint.getSignature().getName();
      logger.info("环绕增强，方法出现异常！");
      logger.error("调用 " + target + " 的 " + name + " 方法发生异常：" + throwable);
      return throwableReturnObject;
    }
  }

}

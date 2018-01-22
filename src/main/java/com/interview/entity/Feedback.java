package com.interview.entity;

import java.sql.Timestamp;

/**
 * @author rxliuli
 */
public class Feedback extends BaseEntity {
  private Long id;
  private Long userLoginId;
  private String content;
  private Timestamp feedbackTime;
  private Byte haveSolve;
  private Long adminId;
  private String solveMethod;
  private Timestamp solveTime;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getUserLoginId() {
    return userLoginId;
  }

  public void setUserLoginId(Long userLoginId) {
    this.userLoginId = userLoginId;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public Timestamp getFeedbackTime() {
    return feedbackTime;
  }

  public void setFeedbackTime(Timestamp feedbackTime) {
    this.feedbackTime = feedbackTime;
  }

  public Byte getHaveSolve() {
    return haveSolve;
  }

  public void setHaveSolve(Byte haveSolve) {
    this.haveSolve = haveSolve;
  }

  public Long getAdminId() {
    return adminId;
  }

  public void setAdminId(Long adminId) {
    this.adminId = adminId;
  }

  public String getSolveMethod() {
    return solveMethod;
  }

  public void setSolveMethod(String solveMethod) {
    this.solveMethod = solveMethod;
  }

  public Timestamp getSolveTime() {
    return solveTime;
  }

  public void setSolveTime(Timestamp solveTime) {
    this.solveTime = solveTime;
  }
}

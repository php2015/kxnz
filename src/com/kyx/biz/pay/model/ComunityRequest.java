package com.kyx.biz.pay.model;

import java.math.BigDecimal;

/**
 * 接收前端传参实体类（充值）
 */
public class ComunityRequest {
    /**
     * 用户id
     */
    private Integer userId;

    /**
     * 套餐id
     */
    private Integer mealId;

    /**
     * 视频id
     */
    private Integer viewId;

    /**
     * 按月购买
     */
    private Integer month;

    /**
     * 套餐标题（一个月VIP会员）
     */
    private String title;


    /**
     * 订单类型：1、VIP充值，2、付费视频充值
     */
    private Integer orderType;

    /**
     * 1、微信，2、支付宝，3、余额
     */
    private Integer payType;
    /**
     * 订单实际支付金额
     */
    private BigDecimal payAmount;


    private static final long serialVersionUID = 1L;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getMealId() {
        return mealId;
    }

    public void setMealId(Integer mealId) {
        this.mealId = mealId;
    }

    public Integer getViewId() {
        return viewId;
    }

    public void setViewId(Integer viewId) {
        this.viewId = viewId;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    public Integer getOrderType() {
        return orderType;
    }

    public void setOrderType(Integer orderType) {
        this.orderType = orderType;
    }

    public Integer getPayType() {
        return payType;
    }

    public void setPayType(Integer payType) {
        this.payType = payType;
    }

    public BigDecimal getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(BigDecimal payAmount) {
        this.payAmount = payAmount;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getBody() {

        if(null != orderType){

            if(1 == orderType.intValue()){

                return  "VIP充值";

            }else if(2 == orderType.intValue()){

                return  "VIP续费";

            }else if(3 == orderType.intValue()){

                return  "付费视频充值";

            }

        }
        return  "其它充值";
    }


    public String getTotalFee() {

        if(null != payAmount){

        return    payAmount.multiply(new BigDecimal(100)).toBigInteger().toString();

        }else{

            return "";
        }

    }
}

package com.kyx.biz.pay.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.kyx.basic.util.RetInfo;
import com.kyx.biz.pay.model.ComunityRequest;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author zl
 *
 */
public interface PayService {
  /**
   * 微信支付下单
   * 
   * @return
   */
  RetInfo unifiedorder(HttpServletRequest request, ComunityRequest comunityRequest);

  /**
   * 支付成功回调函数
   * 
   * @param request
   * @param openId
   * @return
   */
  void notify(HttpServletRequest request, HttpServletResponse response) throws Exception;
}

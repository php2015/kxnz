package com.kyx.biz.wechat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kyx.biz.pay.model.ComunityRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.kyx.basic.util.RetInfo;
import com.kyx.biz.base.controller.BaseController;
import com.kyx.biz.pay.service.PayService;

@Controller
@RequestMapping(value = "/wechat/community/pay")
public class WechatPayController extends BaseController {

  @Autowired
  private PayService payService;

	
	@RequestMapping("/orders")
	@ResponseBody
  public RetInfo orders(HttpServletRequest request, ComunityRequest comunityRequest) {

    return payService.unifiedorder(request,comunityRequest);

  }

  @RequestMapping("/notify")
  public void callBack(HttpServletRequest request, HttpServletResponse response) throws Exception{
    
     payService.notify(request, response);

}
}

package com.kyx.biz.pay.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kyx.basic.user.mapper.UserMapper;
import com.kyx.basic.user.model.User;
import com.kyx.basic.util.AppUtils;
import com.kyx.basic.util.BasicContant;
import com.kyx.biz.app.service.impl.MobileShopsServiceImpl;
import com.kyx.biz.pay.mapper.CommunityMealMapper;
import com.kyx.biz.pay.mapper.CommunityOrderMapper;
import com.kyx.biz.pay.model.CommunityMeal;
import com.kyx.biz.pay.model.CommunityOrder;
import com.kyx.biz.pay.model.ComunityRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kyx.basic.util.RetInfo;
import com.kyx.biz.pay.service.PayService;
import com.kyx.biz.wxutil.HttpRequest;
import com.kyx.biz.wxutil.MyWxConfig;
import com.kyx.biz.wxutil.WXPayUtil;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author zl
 *
 */
@Service("payService")
public class PayServiceImpl implements PayService {

  private Logger logger = LoggerFactory.getLogger(PayServiceImpl.class);
  @Autowired
  private MyWxConfig myWxConfig;
  @Autowired
  private CommunityOrderMapper communityOrderMapper ;
  @Autowired
  private CommunityMealMapper communityMealMapper ;
  @Resource
  private UserMapper userMapper;

  @Override
  public RetInfo unifiedorder(HttpServletRequest request, ComunityRequest comunityRequest) {
    try {
      // 拼接统一下单地址参数
      Map<String, String> paraMap = new HashMap<String, String>();
      // 获取请求ip地址
      String ipAdr = WXPayUtil.getIpAdr(request);
      //获取用户授权的openId
      String openId = (String) request.getSession().getAttribute(BasicContant.WXMP_OPENID_SESSION);
      //获取用户信息
      User user = (User)request.getSession().getAttribute(BasicContant.MASTERWORKER_SESSION);
      //创建订单号
      String orderNo = WXPayUtil.getUniqueOrder();
      // 获取session中的公众号配置(之后可改成读取配置文件)
      paraMap.put("appid", myWxConfig.getAppID());
      paraMap.put("body",comunityRequest.getBody());
      paraMap.put("mch_id", myWxConfig.getMchID());
      paraMap.put("nonce_str", WXPayUtil.generateNonceStr());
      paraMap.put("openid", openId);
      paraMap.put("out_trade_no", orderNo);// 订单号
      paraMap.put("spbill_create_ip", ipAdr);
      paraMap.put("total_fee", comunityRequest.getTotalFee());
      paraMap.put("trade_type", BasicContant.WXMP_PAYTYPE_JSAPI);
      paraMap.put("notify_url", BasicContant.WXMP_NOTIFY_URL);// 此路径是微信服务器调用支付结果通知路径随意写
      String sign = WXPayUtil.generateSignature(paraMap, myWxConfig.getKey());
      paraMap.put("sign", sign);
      String xml = WXPayUtil.mapToXml(paraMap);// 将所有参数(map)转xml格式
      // 统一下单 https://api.mch.weixin.qq.com/pay/unifiedorder
      String xmlStr = HttpRequest.sendPost(BasicContant.WXMP_UNIFIEDORDER_URL, xml);// 发送post请求"统一下单接口"返回预支付id:prepay_id
      Map<String, String> map= WXPayUtil.xmlToMap(xmlStr);
      // 以下内容是返回前端页面的json数据
      if (map.get("return_code").equals("SUCCESS") && map.get("result_code").equals("SUCCESS")) {
        String prepay_id = (String) map.get("prepay_id");
        Map<String, String> payMap = new HashMap<String, String>();
        payMap.put("appId", myWxConfig.getAppID());
        payMap.put("timeStamp", WXPayUtil.getCurrentTimestamp() + "");
        payMap.put("nonceStr", WXPayUtil.generateNonceStr());
        payMap.put("signType", "MD5");
        payMap.put("package", "prepay_id=" + prepay_id);
        String paySign = WXPayUtil.generateSignature(payMap, myWxConfig.getKey());
        payMap.put("paySign", paySign);
        payMap.put("packagse", "prepay_id=" + prepay_id);
        // 创建订单
        CommunityOrder order  = new CommunityOrder();
        Date date = new Date();
        order.setOrderNo(orderNo);
        order.setCreatTime(date);
        order.setUpdateTime(date);
        order.setMealId(comunityRequest.getMealId());
        order.setOrderAmt(comunityRequest.getPayAmount());
        order.setOrderStatus(2);
        order.setPayAmount(comunityRequest.getPayAmount());
        order.setOrderType(comunityRequest.getOrderType());
        order.setPayType(comunityRequest.getPayType());
        order.setUserId(user.getId());
        order.setViewId(comunityRequest.getViewId());
        communityOrderMapper.insertSelective(order);

        return new RetInfo(true, "下单成功", payMap);
      } else {

        return new RetInfo(false, "下单失败");
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
      return new RetInfo(false, "下单失败");
  }

  /**
   * 微信支付成功回调函数
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  public void notify(HttpServletRequest request, HttpServletResponse response) throws Exception{
    InputStream is = null;
    String resXml ="";
    try {
      is = request.getInputStream();// 获取请求的流信息(这里是微信发的xml格式所有只能使用流来读)
      String xml = WXPayUtil.inputStream2String(is, "UTF-8");
      Map<String, String> notifyMap = WXPayUtil.xmlToMap(xml);// 将微信发的xml转map


      if (notifyMap.get("return_code").equals("SUCCESS") && notifyMap.get("result_code").equals("SUCCESS")) {
        logger.info("支付回调成功++++++"+notifyMap.get("out_trade_no")+"+++++++++"+ notifyMap.get("result_code"));
        //验证签名（回调没有授权 任何人都可能访问）
         if(WXPayUtil.isSignatureValid(notifyMap, myWxConfig.getKey())){
          String orderNo = notifyMap.get("out_trade_no");// 商户订单号
          String amountpaid = notifyMap.get("total_fee");// 实际支付的订单金额:单位 分
          resXml = BasicContant.RESSUCCESS_XML;
          BigDecimal amountPay = (new BigDecimal(amountpaid).divide(new BigDecimal("100"))).setScale(2);// 将分转换成元-实际支付金额:元
          String transactionId = notifyMap.get("transaction_id");// 微信支付订单号
          //根据订单号查询订单(判断是否只有一笔订单)
          Integer orderMount = communityOrderMapper.countOrderByOrderNo(orderNo,BasicContant.ORDER_STATUS_TWO);
          if(null != orderMount && orderMount.equals(1)){
            //更新订单的状态，实际支付金额和更新时间用户的等级和到期时间
            CommunityOrder order = communityOrderMapper.selectByOrderNo(orderNo,BasicContant.ORDER_STATUS_TWO);
             //判断订单的操作类型
            if(1 == order.getOrderType().intValue() || 2 == order.getOrderType().intValue()){
              //查询套餐
              CommunityMeal meal =   communityMealMapper.selectByPrimaryKey(order.getMealId());
              //查询用户
              User user = userMapper.selectByPrimaryKey(order.getUserId());
              //计算会员到期时间
              Date day = AppUtils.getDayByMonth(user.getEndTime(), meal.getMonth());
              user.setEndTime(day);
              user.setLevel("2");

              userMapper.updateByPrimaryKeySelective(user);

            }
            order.setId(order.getId());
            order.setPayAmount(amountPay);
            order.setOrderStatus(BasicContant.ORDER_STATUS_THREE);
            order.setUpdateTime(new Date());
            order.setTransactionId(transactionId);
            communityOrderMapper.updateByPrimaryKeySelective(order);
          }
           resXml = "SUCCESS";


      }
      }else{

        resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
      }

    } catch (Exception e) {
      e.printStackTrace();
      throw  e;
    } finally {
      try {
        // 告诉微信服务器收到信息了，不要在调用回调action了========这里很重要回复微信服务器信息用流发送一个xml即可
         WXPayUtil.toPageRseult(response,resXml);

        if (is != null) {

          is.close();
        }
      } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }

    }
  }

}

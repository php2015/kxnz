package com.kyx.biz.wxutil;

import java.io.InputStream;

public class MyWxConfig extends WXPayConfig {

  public String getAppID() {

    return "wx88aa9e73692893d1";
  }

  @Override
  public String getMchID() {

    return "1377594202";
  }

  @Override
  public String getKey() {

    return "7Ntl7m2GIKeLtBDkTa9Q4EK83qX46SGY";
  }


  public String getAppsecret() {

    return "4f011b7c6fa49399013bf7f7b6b463c9";
  }


  public String getToken() {

    return "LIANTU";
  }

  public String getEncodingaeskey() {

    return "lbOwh6P6f2M6olAllxXApnSA7a4b7HbX5Peu2leFkKh";
  }

  @Override
  public InputStream getCertStream() {

    return null;
  }

  @Override
  public IWXPayDomain getWXPayDomain() {

    return null;
  }

}

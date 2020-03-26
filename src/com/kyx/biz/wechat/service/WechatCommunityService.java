package com.kyx.biz.wechat.service;

import com.kyx.basic.car.model.CarVideo;
import com.kyx.basic.user.model.User;
import com.kyx.basic.util.RetInfo;
import com.kyx.biz.wechat.model.WechatCommunity;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 社区模块用户绑定
 */
public interface WechatCommunityService {

    /**
     * 用户登录验证
     * @param account 用户名
     * @param password 密码
     * @param session
     * @param request
     * @return
     */
    RetInfo login(String account, String password, HttpSession session, HttpServletRequest request);
    /**
     * 根据公众号和openid查询师傅登录的信息
     *
     * @param appid
     * @param openId
     * @return
     */
    WechatCommunity getByAppidAndOpenId(String appid, String openId);

    /**
     * 添加微信客户
     *
     * @param appId
     * @param openId
     * @param userName
     * @return
     */
    boolean addWechatCommunity(String appId, String openId, String userName);

    /**
     * 添加微信客户
     *
     * @param session
     * @param userName
     * @return
     */
    boolean addWechatCommunity(HttpSession session, String userName);

    /**
     * 按照用户名称得到微信用户信息
     *
     * @param userName
     * @return
     */
    WechatCommunity getWechatCommunityByUserName(String userName);

    /**
     * 移除微信登录记录信息
     * @param appid
     * @param openId
     * @return
     */
    int removeByAppidAndOpenId(String appid, String openId);

    /**
     * 校验用户是否有权限观看视频
     * @param user
     * @param video
     * @return
     */
    boolean checkUserViewVideo(User user, CarVideo video);
}

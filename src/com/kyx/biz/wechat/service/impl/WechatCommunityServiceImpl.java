package com.kyx.biz.wechat.service.impl;

import com.kyx.basic.car.model.CarVideo;
import com.kyx.basic.db.Dbs;
import com.kyx.basic.user.mapper.UserMapper;
import com.kyx.basic.user.model.User;
import com.kyx.basic.userloginlist.mapper.UserLoginListMapper;
import com.kyx.basic.userloginlist.model.UserLoginList;
import com.kyx.basic.util.BasicContant;
import com.kyx.basic.util.Common;
import com.kyx.basic.util.RetInfo;
import com.kyx.biz.pay.mapper.CommunityOrderMapper;
import com.kyx.biz.wechat.mapper.WechatCommunityMapper;
import com.kyx.biz.wechat.model.WechatCommunity;
import com.kyx.biz.wechat.service.WechatCommunityService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Service("wechatCommunityService")
public class WechatCommunityServiceImpl implements WechatCommunityService {
    @Resource
    private WechatCommunityMapper wechatCommunityMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private BCryptPasswordEncoder passwordEncoder;
    @Resource
    private UserLoginListMapper userLoginListMapper;
    @Resource
    private CommunityOrderMapper communityOrderMapper;


    /**
     * 用户登录验证
     * @param account 用户名
     * @param password 密码
     * @return 登录结果
     */
    @Override
    public RetInfo login(String account, String password, HttpSession session, HttpServletRequest request) {
        if (Common.isEmpty(account) || Common.isEmpty(password)) {
            return new RetInfo(RetInfo.ERROR, "用户名或密码不能为空!");
        } else {
            Dbs.setDbName(Dbs.getMainDbName());
            User user = userMapper.queryExistUserName(account);
            if (user == null || !passwordEncoder.matches(password, user.getUserPassword())) {
                return new RetInfo(RetInfo.ERROR, "用户或密码不正确！");
            } else if (!"1".equals(user.getEnable())) {
                return new RetInfo(RetInfo.ERROR, "当前用户不可用, 请联系管理员!");
            } else {
                // 记录登录信息
                UserLoginList userLoginList = new UserLoginList();
                userLoginList.setUserId(user.getId());
                userLoginList.setLoginTime(new Date());
                userLoginList.setLoginIp(Common.toIpAddr(request));
                userLoginList.setShopId(user.getShopId());
                userLoginListMapper.insertSelective(userLoginList);
                session.setAttribute(BasicContant.MASTERWORKER_SESSION, user);
                addWechatCommunity(session, user.getUserName());
                return new RetInfo(RetInfo.SUCCESS, "登陆成功!");
            }
        }
    }
    /**
     * 根据公众号和openid查询师傅登录的信息
     *
     * @param appid
     * @param openId
     * @return
     */
    @Override
    public WechatCommunity getByAppidAndOpenId(String appid, String openId) {
        List<WechatCommunity> exist = wechatCommunityMapper.getByAppidAndOpenId(appid, openId);
        if(exist == null) return null;
        else if(exist.size() == 1) return exist.get(0);
        else {
            wechatCommunityMapper.removeByAppidAndOpenId(appid, openId);
            return null;
        }
    }
    /**
     * 添加微信客户
     *
     * @param appId
     * @param openId
     * @param userName
     * @return
     */
    @Override
    public boolean addWechatCommunity(String appId, String openId, String userName) {
        WechatCommunity community = new WechatCommunity(appId, openId, userName);
        return wechatCommunityMapper.insertSelective(community) > 0;
    }

    /**
     * 添加微信客户
     *
     * @param session
     * @param userName
     * @return
     */
    @Override
    public boolean addWechatCommunity(HttpSession session, String userName) {
        Object attribute = session.getAttribute(BasicContant.WXMP_OPENID_SESSION);
        Object attribute1 =  session.getAttribute(BasicContant.WXMP_APPID_SESSION);
        if (attribute != null && attribute1 != null) {
            String openId = (String) attribute;
            String appid = (String) attribute1;
            List<WechatCommunity> exist = wechatCommunityMapper.getByAppidAndOpenId(appid, openId);
            if(exist == null || exist.isEmpty()){
                WechatCommunity community = new WechatCommunity(appid, openId, userName);
                return wechatCommunityMapper.insertSelective(community) > 0;
            }
        }
        return false;
    }

    /**
     * 按照用户名称得到微信用户信息
     *
     * @param userName
     * @return
     */
    @Override
    public WechatCommunity getWechatCommunityByUserName(String userName) {
        return wechatCommunityMapper.selectByUserName(userName);
    }

    /**
     * 移除微信登录记录信息
     * @param appid
     * @param openId
     * @return
     */
    @Override
    public int removeByAppidAndOpenId(String appid, String openId) {
        return wechatCommunityMapper.removeByAppidAndOpenId(appid, openId);
    }

    /**
     * 校验用户是否有权限观看视频
     * @param user 用户信息
     * @param video 视频信息
     * @return 是否有权限
     */
    @Override
    public boolean checkUserViewVideo(User user, CarVideo video) {
        boolean autoPlay = false;
        if(video != null && user != null){
            boolean isVip = user.getEndTime() != null && user.getEndTime().getTime() > (new Date()).getTime();
            if(BasicContant.CarVideoMember.NORMAL.getCode().equals(video.getMember())){ // 免费
                autoPlay = true;
            }else {
                autoPlay = isVip || communityOrderMapper.countByUserIdAndViewId(user.getId(), video.getId()) > 0;
            }
        }
        return autoPlay;
    }
}

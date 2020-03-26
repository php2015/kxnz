package com.kyx.biz.wechat.service.impl;

import com.kyx.basic.util.BasicContant;
import com.kyx.biz.wechat.mapper.WechatCommunityMapper;
import com.kyx.biz.wechat.model.WechatCommunity;
import com.kyx.biz.wechat.service.WechatCommunityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Service("wechatCommunityService")
public class WechatCommunityServiceImpl implements WechatCommunityService {
    @Resource
    private WechatCommunityMapper wechatCommunityMapper;

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

    @Override
    public boolean addWechatCommunity(String appId, String openId, String userName) {
        WechatCommunity community = new WechatCommunity(appId, openId, userName);
        return wechatCommunityMapper.insertSelective(community) > 0;
    }

    @Override
    public boolean addWechatCommunity(HttpSession session, String userName) {
        Object attribute = session.getAttribute(BasicContant.WXMP_OPENID_SESSION);
        if (attribute != null) {
            String openId = (String) attribute;
            String appid = (String) session.getAttribute(BasicContant.WXMP_APPID_SESSION);
            List<WechatCommunity> exist = wechatCommunityMapper.getByAppidAndOpenId(appid, openId);
            if(exist == null || exist.isEmpty()){
                WechatCommunity community = new WechatCommunity(appid, openId, userName);
                return wechatCommunityMapper.insertSelective(community) > 0;
            }
        }
        return false;
    }

    @Override
    public WechatCommunity getWechatCommunityByUserName(String userName) {
        return wechatCommunityMapper.selectByUserName(userName);
    }

    @Override
    public int removeByAppidAndOpenId(String appid, String openId) {
        return wechatCommunityMapper.removeByAppidAndOpenId(appid, openId);
    }
}

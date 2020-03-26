package com.kyx.biz.pay.service.impl;

import com.kyx.biz.pay.mapper.CommunityOrderMapper;
import com.kyx.biz.pay.service.CommunityOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("communityOrderService")
public class CommunityOrderServiceImpl implements CommunityOrderService {

    @Autowired
    private CommunityOrderMapper communityOrderMapper ;
    /**
     * 根据用户ID和视频ID查询订单
     * @param userId
     * @param viewId
     * @return
     */
    @Override
    public boolean queryByUseIdAndViewId(Integer userId, Integer viewId) {
        boolean flag = false ;
        Integer mount = communityOrderMapper.countByUserIdAndViewId(userId, viewId);
        if(null != mount && mount.intValue() >= 1){

            flag = true;

        }
        return flag;
    }
}

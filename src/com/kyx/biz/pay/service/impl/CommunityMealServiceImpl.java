package com.kyx.biz.pay.service.impl;

import com.kyx.biz.pay.mapper.CommunityMealMapper;
import com.kyx.biz.pay.model.CommunityMeal;
import com.kyx.biz.pay.service.CommunityMealService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service("communityMealService")
public class CommunityMealServiceImpl implements CommunityMealService {
     @Resource
     private CommunityMealMapper communityMealMapper;
    /**
     * @return 查询VIP套餐列表
     */
    @Override
    public List<CommunityMeal> queryComunityMeal() {

        return  communityMealMapper.selectAll();

    }
}

package com.kyx.biz.pay.mapper;

import com.kyx.biz.pay.model.CommunityMeal;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("communityMealMapper")
public interface CommunityMealMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CommunityMeal record);

    int insertSelective(CommunityMeal record);

    CommunityMeal selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CommunityMeal record);

    int updateByPrimaryKey(CommunityMeal record);


    List<CommunityMeal> selectAll();
}
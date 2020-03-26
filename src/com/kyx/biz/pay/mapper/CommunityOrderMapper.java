package com.kyx.biz.pay.mapper;

import com.kyx.biz.pay.model.CommunityOrder;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository("communityOrderMapper")
public interface CommunityOrderMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CommunityOrder record);

    int insertSelective(CommunityOrder record);

    CommunityOrder selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CommunityOrder record);

    int updateByPrimaryKey(CommunityOrder record);

    Integer countOrderByOrderNo(@Param("orderNo")String orderNo ,@Param("orderStatus") Integer orderStatus);

    CommunityOrder selectByOrderNo(@Param("orderNo")String orderNo ,@Param("orderStatus") Integer orderStatus);

    Integer countByUserIdAndViewId(@Param("userId")Integer userId ,@Param("viewId") Integer viewId);

}
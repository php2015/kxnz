package com.kyx.biz.wechat.mapper;

import com.kyx.biz.wechat.model.WechatCommunity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("wechatCommunityMapper")
public interface WechatCommunityMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(WechatCommunity record);

	int insertSelective(WechatCommunity record);

	WechatCommunity selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(WechatCommunity record);

	int updateByPrimaryKey(WechatCommunity record);

	List<WechatCommunity> getByAppidAndOpenId(@Param(value = "appId") String appId,
											  @Param(value = "openId") String openId);
	WechatCommunity selectByUserName(@Param(value = "userName") String userName);

	int removeByAppidAndOpenId(@Param(value = "appId") String appId,
							   @Param(value = "openId") String openId);
}
package com.kyx.basic.car.mapper;

import com.kyx.basic.car.model.CarVideo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CarVideoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CarVideo record);

    int insertSelective(CarVideo record);

    CarVideo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CarVideo record);

    int updateByPrimaryKey(CarVideo record);

    List<CarVideo> queryCarVideoBySeriesId(@Param("classId") Integer classId, @Param("seriesId") Integer seriesId, @Param("modelId") Integer modelId);

    CarVideo queryCarVideoById(Integer id);

    /**
     *@描述 查询最热视频列表
     *@Author XYANG
     *@Date 2020/3/21 0021 10:13
     *@返回值
     */
    List<CarVideo> queryHotList();

    /**
     *@描述 查询最新视频列表
     *@Author XYANG
     *@Date 2020/3/21 0021 10:13
     *@返回值
     */
    List<CarVideo> queryNewList();
}
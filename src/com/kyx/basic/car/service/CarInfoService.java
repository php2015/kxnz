package com.kyx.basic.car.service;

import com.kyx.basic.car.model.*;
import com.kyx.basic.util.Pager;

import java.util.List;

public interface CarInfoService {
    /**
     * 下载车型信息
     * @param letter
     */
    void downloadCarInfo(String letter);

    /**
     * 查询类目
     * @return
     */
    List<CarCategory> queryCarCategoryList();

    /**
     * 根据类目查询品牌
     * @param category
     * @return
     */
    List<CarBrand> queryCarBrandList(int category);

    /**
     * 根据品牌查询车系
     * @param brandId
     * @return
     */
    List<CarSeries> queryCarSeriesList(int brandId);

    /**
     * 根据品牌和车系查询车型
     * @param brandId
     * @param seriesId
     * @return
     */
    List<CarModel> queryCarModelList(int seriesId);

    /**
     * 根据品牌和车系查询车型年代款
     * @param brandId
     * @param seriesId
     * @return
     */
    List<String> queryCarModelYears(int seriesId);

    /**
     * 根据车系和年代, 查询车型列表数据
     * @param series 车系id
     * @param year 年代
     * @return
     */
    List<CarModel> queryCarModelList(Integer series, String year);

    /**
     * 查询视频类型列表
     * @return
     */
    List<CarVideoClass> queryCarVideoClass();

    /**
     * 按视频类型,车系和车型查询数据
     * @param classId 类型id
     * @param seriesId 车系id
     * @param modelId 车型id
     */
    List<CarVideo> queryCarVideoBySeriesId(Integer classId, Integer seriesId, Integer modelId);

    /**
     * 根据id获取视频信息
     * @param videoId
     * @return
     */
    CarVideo queryCarVideoById(Integer videoId);

    /**
     * 模糊检索车型信息.空值时显示全部
     *
     * @param search 检索内容, 为空时显示全部
     * @param page   分页数据
     * @return
     */
    List<CarModel> searchCarModelList(String search, Pager page);

    /**
     * 首页最热最新视频列表
     * @param type 查询类型(hot, new)
     * @param page 分页查询{page, limit}
     * @return
     */
    List<CarVideo> videoIndexList(String type, Pager pager);

    /**
     * package: com.kyx.basic.car.service
     * describe: 更新视频信息
     * creat_user: xyang
     * @param video
     * date: 2020/3/26 0026 9:06
     **/
    boolean updateCarVideoInfo(CarVideo video);

    /**
     * 视频浏览量增加
     * @param video 视频信息
     * @return 增加是否成功
     */
    boolean addCarVideoBrowser(CarVideo video);
}

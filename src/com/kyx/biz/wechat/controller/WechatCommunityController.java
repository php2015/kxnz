package com.kyx.biz.wechat.controller;

import com.alibaba.fastjson.JSON;
import com.kyx.basic.annotation.SystemControllerLog;
import com.kyx.basic.car.model.*;
import com.kyx.basic.car.service.CarInfoService;
import com.kyx.basic.db.Dbs;
import com.kyx.basic.sysparam.model.SysBasicInfo;
import com.kyx.basic.sysparam.service.SysBasicInfoService;
import com.kyx.basic.user.model.User;
import com.kyx.basic.user.service.UserService;
import com.kyx.basic.userloginlist.model.UserLoginList;
import com.kyx.basic.userloginlist.service.UserLoginListService;
import com.kyx.basic.util.BasicContant;
import com.kyx.basic.util.Common;
import com.kyx.basic.util.Pager;
import com.kyx.basic.util.RetInfo;
import com.kyx.biz.wechat.service.WechatCommunityService;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/wechat/community")
public class WechatCommunityController {
    @Resource
    private UserService userService;
    @Resource
    private WechatCommunityService wechatCommunityService;
    @Resource
    private BCryptPasswordEncoder passwordEncoder;
    @Resource
    private UserLoginListService userLoginListService;
    @Resource
    private CarInfoService carInfoService;
    @Resource
    private SysBasicInfoService sysBasicInfoService;

    @RequestMapping("index")
    public String index(Model model, User user){
        Dbs.setDbName(Dbs.getMainDbName());
        // 轮播图
        List<SysBasicInfo> banners = sysBasicInfoService.queryBasicInfosByFlag(SysBasicInfo.BANNERS);
        // 满足mui显示轮播图样式, 首位各多添加一张图片
        if (banners != null && !banners.isEmpty()) {
            banners.add(0, banners.get(banners.size() - 1));
            banners.add(banners.get(0));
        }
        model.addAttribute("banners", banners);
        // 视频类型
        List<CarVideoClass> videoClasses = carInfoService.queryCarVideoClass();
        model.addAttribute("videoClass", videoClasses);

        List<CarCategory> categories = carInfoService.queryCarCategoryList();
        model.addAttribute("categorys", categories);

        Pager pager = new Pager();
        pager.setLimit(20);
        List<CarVideo> carVideos = carInfoService.videoIndexList("Hot", pager);
        model.addAttribute("hotVideos", carVideos);

        return "community/index";
    }

    /**
     * 注册用户
     *
     * @return
     */
    @RequestMapping("/regIndex")
    public String regIndex(HttpSession session, Model model) {
        if (session.getAttribute(BasicContant.MASTERWORKER_SESSION) != null) {
            return "redirect:/wechat/community/index.do";
        }
        Object attribute = session.getAttribute(BasicContant.WXMPUSER_SESSION);
        if (attribute != null) {
            WxMpUser wxMpUser = (WxMpUser) attribute;
            model.addAttribute("userPhoto", wxMpUser.getHeadImgUrl());
            model.addAttribute("nickName", wxMpUser.getNickname());
            model.addAttribute("userSex", wxMpUser.getSex() == 1 ? 1 : 0);
            model.addAttribute("userAddress", (wxMpUser.getProvince() == null ? "" : wxMpUser.getProvince()) +
                    (wxMpUser.getCity() == null ? "" : wxMpUser.getCity()));
        }
        return "community/regIndex";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    @SystemControllerLog(module = "微信社区员工管理", description = "注册员工")
    public RetInfo register(String userJson, HttpSession session) {
        if (StringUtils.isBlank(userJson)) {
            return new RetInfo(false, "注册信息错误, 请重新填写!");
        }
        User user = JSON.parseObject(userJson, User.class);
        Dbs.setDbName(Dbs.getMainDbName());
        RetInfo retInfo = userService.wechatRegisterUser(user);
        if (RetInfo.SUCCESS.equals(retInfo.getRetCode())) {
            session.setAttribute(BasicContant.MASTERWORKER_SESSION, retInfo.getRetData());
            wechatCommunityService.addWechatCommunity(session, user.getUserPhone());
        }
        return retInfo;
    }


    /**
     * 用户登录验证
     *
     * @param account  登录用户名
     * @param password 密码
     * @param session
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public RetInfo login(String account, String password, HttpSession session, HttpServletRequest request) {
        if (Common.isEmpty(account) || Common.isEmpty(password)) {
            return new RetInfo(RetInfo.ERROR, "用户名或密码不能为空!");
        } else {
            Dbs.setDbName(Dbs.getMainDbName());
            User user = userService.queryExistUserName(account);
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
                userLoginListService.add(userLoginList);
                session.setAttribute(BasicContant.MASTERWORKER_SESSION, user);
                wechatCommunityService.addWechatCommunity(session, user.getUserName());
                return new RetInfo(RetInfo.SUCCESS, "登陆成功!");
            }
        }

    }

    /**
     * 忘记密码
     *
     * @return
     */
    @RequestMapping("/pwdIndex")
    public String pwdIndex() {
        return "community/pwdIndex";
    }

    @RequestMapping("/page/{pageName}.do")
    public String page(@PathVariable("pageName") String pageName) {
        return "community/" + pageName;
    }

    /**
     * package: com.kyx.biz.wechat.controller
     * describe: 车类型
     * creat_user: xyang
     * date: 2020/3/25 0025 11:30
     **/
    @RequestMapping("/car/category")
    @ResponseBody
    public List<CarCategory> category() {
        Dbs.setDbName(Dbs.getMainDbName());
        return carInfoService.queryCarCategoryList();
    }

    /**
     * 根据类别id, 获取品牌列表
     *
     * @param category 类别id
     * @return
     */
    @RequestMapping("/car/brands")
    @ResponseBody
    public List<CarBrand> getBrands(Integer category) {
        Dbs.setDbName(Dbs.getMainDbName());
        return carInfoService.queryCarBrandList(category);
    }

    /**
     * 模糊检索车型信息
     *
     * @param category 类别id
     * @return
     */
    @RequestMapping("/car/search")
    @ResponseBody
    public List<CarModel> carSearch(String search, Pager pager) {
        Dbs.setDbName(Dbs.getMainDbName());
        if (pager == null) {
            pager = new Pager();
        }
        return carInfoService.searchCarModelList(search, pager);
    }

    /**
     * 轮播图片
     *
     * @param category 类别id
     * @return
     */
    @RequestMapping("/banners")
    @ResponseBody
    public List<SysBasicInfo> indexBanners() {
        Dbs.setDbName(Dbs.getMainDbName());
        return sysBasicInfoService.queryBasicInfosByFlag(SysBasicInfo.BANNERS);
    }

    /**
     * 首页最热最新视频列表
     * @param type 查询类型(hot, new)
     * @return
     */
    @RequestMapping("/video/indexList")
    @ResponseBody
    public List<CarVideo> videoIndexList(String type, Pager pager) {
        Dbs.setDbName(Dbs.getMainDbName());
        if (pager == null) {
            pager = new Pager();
        }
        return carInfoService.videoIndexList(type, pager);
    }

    /**
     * 首页最热最新视频列表
     * @param type 查询类型(hot, new)
     * @return
     */
    @RequestMapping("/video/typeVideoList")
    public String videoIndexList(Integer classId, String title, Integer seriesId, Integer modelId, Model model) {
        model.addAttribute("title", title);
        model.addAttribute("videoList", carInfoService.queryCarVideoBySeriesId(classId, seriesId, modelId));
        return "community/videos/videoList";
    }


    /**
     * 视频播放页面
     * @param videoId 视频id
     * @return
     */
    @RequestMapping("/video/toVideoPlayer")
    public String toVideoPlayer(Integer videoId, HttpSession session, Model model){
        Dbs.setDbName(Dbs.getMainDbName());
        CarVideo video = carInfoService.queryCarVideoById(videoId);
        User user = (User)session.getAttribute(BasicContant.MASTERWORKER_SESSION);
        user = userService.selectByPrimaryKey(user.getId());
        model.addAttribute("user", user);
        boolean autoPlay = false;
        boolean isVip = user.getEndTime() != null && user.getEndTime().getTime() > (new Date()).getTime();
        model.addAttribute("vip", isVip ? "vip" : "");
        if(video != null){
            if(CarVideo.Member.NORMAL.getCode().equals(video.getMember())){ // 免费
                autoPlay = true;
            }else {
                if(isVip){//是会员
                    autoPlay = true;
                }else{ // 无会员或已到期
                    autoPlay = true;
                }
            }
        }

        if(autoPlay){
            model.addAttribute("autoPlay", "autoPlay");
            video.setBrowseNum(video.getBrowseNum() + 1);
            CarVideo update = new CarVideo();
            update.setBrowseNum(video.getBrowseNum());
            update.setId(videoId);
            carInfoService.updateCarVideoInfo(update);
            // 添加观看历史记录

        }
        model.addAttribute("video", video);
        return "community/videos/carVideoPlayer";
    }

}

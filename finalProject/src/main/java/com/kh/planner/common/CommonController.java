package com.kh.planner.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.planner.festival.controller.FestivalController;

@Controller
public class CommonController { // 공통으로 쓰는 컨트롤러
	private String tourapikey = "?ServiceKey=kLZYhnukkkQDzQJ58%2FtZe6IjLUnEn%2FTtuQiqyzSwbiJ8e9SiuyV3xFtgwUu9jpqT33DASyAZb8ST3r3xGD4PJQ%3D%3D";
	private String forecastkey = "?ServiceKey=kLZYhnukkkQDzQJ58%2FtZe6IjLUnEn%2FTtuQiqyzSwbiJ8e9SiuyV3xFtgwUu9jpqT33DASyAZb8ST3r3xGD4PJQ%3D%3D";
	private String tourParams = "&MobileOS=ETC&MobileApp=planner&_type=json";
	
	private static final Logger logger = LoggerFactory.getLogger(FestivalController.class);
	
	@RequestMapping(value = "header.do")
	public String header() {
		return "common/header";
	}
	
	@RequestMapping(value = "footer.do")
	public String footer() {
		return "common/footer";
	}
	
	// tourApi의 정보 중 하나의 상세 정보 페이지로 이동(축제는 eventstartdate 넘어온 걸로 판별 가능할지도?)
	@RequestMapping("contentDetail.do")
	public ModelAndView contentDetail(ModelAndView mv,
			@RequestParam(value="sidoName", defaultValue = "-1") String sidoName,
			@RequestParam(value="sidoCode", defaultValue = "-1") String sidoCode,
			@RequestParam(value="sigunguName", defaultValue = "-1") String sigunguName,
			@RequestParam(value="sigunguCode", defaultValue = "-1") String sigunguCode,
			@RequestParam(value="contenttypename", defaultValue = "-1") String contenttypename,
			@RequestParam(value="contenttypeid", defaultValue="-1") int contenttypeid,
			@RequestParam(value="contentid", defaultValue="-1") int contentid,
			@RequestParam(value="eventstartdate", defaultValue="-1") int eventstartdate,
			@RequestParam(value="eventenddate", defaultValue="-1") int eventenddate,
			@RequestParam(value="title", defaultValue = "-1") String title) {
		
		mv.addObject("sidoName", sidoName);
		mv.addObject("sidoCode", sidoCode);
		mv.addObject("sigunguName", sigunguName);
		mv.addObject("sigunguCode", sigunguCode);
		mv.addObject("contenttypename", contenttypename);
		mv.addObject("contenttypeid", contenttypeid);
		mv.addObject("contentid", contentid);
		mv.addObject("eventstartdate", eventstartdate);
		mv.addObject("eventenddate", eventenddate);	
		mv.addObject("title", title);
		mv.setViewName("area/contentDetail");
		
		logger.info("contentDetail.do : " + mv.toString());
		return mv;
	}
	
	// tourApi의 정보 하나의 공통정보
	
}

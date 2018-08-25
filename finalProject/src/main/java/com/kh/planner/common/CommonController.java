package com.kh.planner.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value = "area_header.do")
	public String area_header() {
		return "area/area_header";
	}
	
	
	// tourApi의 정보 중 하나의 상세 정보 페이지로 이동(축제는 eventstartdate 넘어온 걸로 판별 가능할지도? 보다는 contenttypeid로 판별하자)
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
		if(-1 != eventstartdate) mv.addObject("eventstartdate", eventstartdate);
		if(-1 != eventenddate) mv.addObject("eventenddate", eventenddate);	
		mv.addObject("title", title);
		mv.setViewName("area/contentDetail");
		
		logger.info("contentDetail.do : " + mv.toString());
		return mv;
	}
	
	// tourApi의 정보 하나의 공통정보
	@RequestMapping(value = "detailCommon.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String detailCommon(
			@RequestParam(value="contenttypeid", defaultValue = "-1") int contenttypeid,
			@RequestParam(value="contentid", defaultValue = "-1") int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+contenttypeid); // 컨텐츠 분류 id
		params.append("&defaultYN=Y"); // 기본정보 조회 여부
		params.append("&firstImageYN=Y"); // 대표이미지 조회
		params.append("&areacodeYN=Y"); // 지역코드 조회
		params.append("&catcodeYN=Y"); // 서비스분류코드 조회
		params.append("&addrinfoYN=Y"); // 주소 조회
		params.append("&mapinfoYN=Y"); // 좌표 조회
		params.append("&overviewYN=Y"); // 개요 조회	
		String result = JsonManager.getJsonString(address + params.toString()); // 바이트 출력 스트림에서 json 문자열을 받을 변수
		return result;
	}
	
	// tourApi의 정보 하나의 상세정보
	@RequestMapping(value = "detailIntro.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String detailIntro(
			@RequestParam(value="contenttypeid", defaultValue = "-1") int contenttypeid,
			@RequestParam(value="contentid", defaultValue = "-1") int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+contenttypeid); // 컨텐츠 분류 id
		params.append("&introYN=Y"); // 소개정보 조회	
		String result = JsonManager.getJsonString(address + params.toString()); // 바이트 출력 스트림에서 json 문자열을 받을 변수
		return result;
	}
	
	// tourApi의 정보 하나의 반복정보
	@RequestMapping(value = "detailInfo.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String detailInfo(
			@RequestParam(value="contenttypeid", defaultValue = "-1") int contenttypeid,
			@RequestParam(value="contentid", defaultValue = "-1") int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailInfo";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+contenttypeid); // 컨텐츠 분류 id
		params.append("&detailYN=Y"); // 반복정보 조회
		String result = JsonManager.getJsonString(address + params.toString()); // 바이트 출력 스트림에서 json 문자열을 받을 변수
		return result;
	}
	
	// tourApi의 정보 하나의 이미지들
	@RequestMapping(value = "detailImage.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String detailImage(
			@RequestParam(value="contentid", defaultValue = "-1") int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailImage";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&numOfRows=1000");
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&imageYN=Y"); // 컨텐츠 분류 id
		params.append("&subImageYN=Y"); // 반복정보 조회
		String result = JsonManager.getJsonString(address + params.toString()); // 바이트 출력 스트림에서 json 문자열을 받을 변수
		return result;
	}
	
	// 지역 맞춤형 일기예보 조회 : 참고로 위경도 변환 가능하니 그거 쓰도록!
	@RequestMapping(value = "forecast.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String forecast(double mapx, double mapy){	
		String address = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData";
		StringBuilder params = new StringBuilder(forecastkey);
		params.append("&numOfRows=10000"); // 모든 기상 정보
		// 발표일 : 오늘, 동네예보 기준
		SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd-kkmm"); // 오늘 날짜를 뽑아옴
		String todayStr = today.format(new Date());
		String currentDate = todayStr.split("-")[0];
		String currentTime = todayStr.split("-")[1];
		String baseTime; // 진짜 보낼 값	
		params.append("&base_date="+currentDate);
		// 동네예보 기준으로 시간 맞춤
		if("0210".compareTo(currentTime) <= 0 && "0510".compareTo(currentTime) > 0) {
			baseTime = "0200";
		}else if("0510".compareTo(currentTime) <= 0 && "0810".compareTo(currentTime) > 0) {
			baseTime = "0500";
		}else if("0810".compareTo(currentTime) <= 0 && "1110".compareTo(currentTime) > 0) {
			baseTime = "0800";
		}else if("1110".compareTo(currentTime) <= 0 && "1410".compareTo(currentTime) > 0) {
			baseTime = "1100";
		}else if("1410".compareTo(currentTime) <= 0 && "1710".compareTo(currentTime) > 0) {
			baseTime = "1400";
		}else if("1710".compareTo(currentTime) <= 0 && "2010".compareTo(currentTime) > 0) {
			baseTime = "1700";
		}else if("2010".compareTo(currentTime) <= 0 && "2310".compareTo(currentTime) > 0) {
			baseTime = "2000";
		}else{
			baseTime = "2300";
		}
		params.append("&base_time="+baseTime);
		// 좌표 결정
		Map<String, Double> grid = GPStoGRIDConverter.convertToGRID(mapx, mapy);
			
		params.append("&nx="+grid.get("nx").intValue());
		params.append("&ny="+grid.get("ny").intValue());
		params.append("&_type=json"); // json으로
		
		logger.info("forecast.do : " + grid.get("nx").intValue() + ", " + grid.get("ny").intValue());		
		
		String result = JsonManager.getJsonString(address + params.toString()); // 바이트 출력 스트림에서 json 문자열을 받을 변수
		return result;
	}
	
	// 주변 1km 내 정보 조회
	@RequestMapping(value = "locationBasedList.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String locationBasedList(double mapx, double mapy, int contenttypeid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentTypeId="+contenttypeid); // 컨텐츠 분류 id
		params.append("&mapX="+mapx); // x 좌표
		params.append("&mapY="+mapy); // y 좌표
		params.append("&radius=1000"); // 거리 반경(m)
		
		String result = JsonManager.getJsonString(address + params.toString()); // 바이트 출력 스트림에서 json 문자열을 받을 변수
		return result;
	}
}

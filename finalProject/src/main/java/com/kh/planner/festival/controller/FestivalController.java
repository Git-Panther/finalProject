package com.kh.planner.festival.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.planner.common.GPStoGRIDConverter;

@Controller
public class FestivalController {
	private String tourapikey = "?ServiceKey=kLZYhnukkkQDzQJ58%2FtZe6IjLUnEn%2FTtuQiqyzSwbiJ8e9SiuyV3xFtgwUu9jpqT33DASyAZb8ST3r3xGD4PJQ%3D%3D";
	private String forecastkey = "?ServiceKey=kLZYhnukkkQDzQJ58%2FtZe6IjLUnEn%2FTtuQiqyzSwbiJ8e9SiuyV3xFtgwUu9jpqT33DASyAZb8ST3r3xGD4PJQ%3D%3D";
	private String tourParams = "&MobileOS=ETC&MobileApp=planner&_type=json";
	
	private static final Logger logger = LoggerFactory.getLogger(FestivalController.class);
	
	@RequestMapping("festivalList.do") // 리스트 표시하는 페이지로 이동
	public ModelAndView festivalList(ModelAndView mv
			, @RequestParam(value="pageNo", defaultValue="1") String pageNo
			, @RequestParam(value="arrange", defaultValue="") String arrange
			, @RequestParam(value="areaCode", defaultValue="") String areaCode
			, @RequestParam(value="sigunguCode", defaultValue="") String sigunguCode
			, @RequestParam(value="eventStartDate", defaultValue="") String eventStartDate
			, @RequestParam(value="eventEndDate", defaultValue="") String eventEndDate) {
		if(null != arrange && !"".equals(arrange)) mv.addObject("arrange", arrange);
		if(null != pageNo && !"".equals(pageNo)) mv.addObject("pageNo", pageNo);
		else mv.addObject("pageNo", "1");
			
		if(null != areaCode && !"".equals(areaCode)) mv.addObject("areaCode", areaCode);
		if(null != sigunguCode && !"".equals(sigunguCode)) mv.addObject("sigunguCode", sigunguCode);
		if(null != eventStartDate && !"".equals(eventStartDate)) mv.addObject("eventStartDate", eventStartDate);
		if(null != eventEndDate && !"".equals(eventEndDate)) mv.addObject("eventEndDate", eventEndDate);
		mv.setViewName("festival/festivalList");
		logger.info(pageNo + ", " + arrange + ", " + areaCode + ", " + sigunguCode + ", " + eventStartDate + ", " + eventEndDate);
		return mv;
	}
	
	// 주요 도시 검색(지역 코드가 있으면 지역 코드 기반하여 시군구 찾음)
	@RequestMapping(value = "areaCodeList.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String areaCodeList(String areaCode){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&numOfRows=100"); // 모든 주요 도시
		if(null != areaCode) params.append("&areaCode="+areaCode); // 지역코드가 있으면 그 지역의 시군구, 아니면 주요 도시 전체
		logger.info(address + params.toString());
		
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	// 축제 리스트 불러오기
	@RequestMapping(value = "selectFestivalList.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalApi(String pageNo, String arrange, String areaCode, String sigunguCode
			, String eventStartDate, String eventEndDate){ // 페이지 번호, 정렬 기준	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&numOfRows=12"); // 한 번에 조회하는 정보 : 12개
		params.append("&pageNo="+ (null != pageNo ? pageNo : "1")); // x페이지
		params.append("&arrange=" + (null != arrange ? arrange : "D")); // D 조건(생성일순)으로 정렬 -> C 조건(수정일 순) -> Q(이미지 있는 수정일 순)
		if(null != areaCode) params.append("&areaCode="+areaCode); // 지역코드 : 전체
		if(null != sigunguCode) params.append("&sigunguCode="+sigunguCode); // 지역코드 : 시군구 - 안 따짐
		if(null != eventStartDate) params.append("&eventStartDate="+eventStartDate.replaceAll("-", "")); // 1월 1일부터
		if(null != eventEndDate) params.append("&eventEndDate="+eventEndDate.replaceAll("-", "")); // 12월 3일까지
		
		logger.info(pageNo + ", " + arrange + ", " + areaCode + ", " + sigunguCode + ", " + eventStartDate + ", " + eventEndDate);
		
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	// 축제 상세 정보 페이지로 이동
	@RequestMapping("festival.do")
	public ModelAndView festivalDetail(ModelAndView mv
			, @RequestParam(value="contentid", defaultValue="0") int contentid
			, @RequestParam(value="eventstartdate", defaultValue="0") int eventstartdate
			, @RequestParam(value="eventenddate", defaultValue="0") int eventenddate) {
		mv.addObject("contentid", contentid);
		mv.addObject("eventstartdate", eventstartdate);
		mv.addObject("eventenddate", eventenddate);	
		mv.setViewName("festival/festivalDetail");
		return mv;
	}
	
	// 축제 공통정보 조회
	@RequestMapping(value = "festivalDetailCommon.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalDetailCommon(int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+15); // 컨텐츠 분류 id
		params.append("&defaultYN=Y"); // 기본정보 조회 여부
		params.append("&firstImageYN=Y"); // 대표이미지 조회
		params.append("&areacodeYN=Y"); // 지역코드 조회
		params.append("&catcodeYN=Y"); // 서비스분류코드 조회
		params.append("&addrinfoYN=Y"); // 주소 조회
		params.append("&mapinfoYN=Y"); // 좌표 조회
		params.append("&overviewYN=Y"); // 개요 조회
		
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	// 축제 상세정보 조회
	@RequestMapping(value = "festivalDetailIntro.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalDetailIntro(int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+15); // 컨텐츠 분류 id
		params.append("&introYN=Y"); // 소개정보 조회
	
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	// 축제 상세정보 조회
	@RequestMapping(value = "festivalDetailInfo.do", method = RequestMethod.POST, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalDetailInfo(int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailInfo";
		StringBuilder params = new StringBuilder(tourapikey + tourParams);
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+15); // 컨텐츠 분류 id
		params.append("&detailYN=Y"); // 반복정보 조회
		
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
		
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
		
		logger.info(grid.get("nx").intValue() + ", " + grid.get("ny").intValue());		
		
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(address + params.toString());
			in = url.openStream();
			bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();
			result = bos1.toString();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}

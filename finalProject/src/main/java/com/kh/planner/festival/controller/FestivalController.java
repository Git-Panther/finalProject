package com.kh.planner.festival.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FestivalController {
	private String key = "kLZYhnukkkQDzQJ58%2FtZe6IjLUnEn%2FTtuQiqyzSwbiJ8e9SiuyV3xFtgwUu9jpqT33DASyAZb8ST3r3xGD4PJQ%3D%3D";
	
	private static final Logger logger = LoggerFactory.getLogger(FestivalController.class);
	
	@RequestMapping("festivalList.do") // 리스트 표시하는 페이지로 이동
	public ModelAndView festivalList(ModelAndView mv, String pageNo, String arrange, String areaCode, String sigunguCode
			, String eventStartDate, String eventEndDate) {
		if(null != arrange) mv.addObject("arrange", arrange);
		if(null != pageNo) mv.addObject("pageNo", pageNo);
		else mv.addObject("pageNo", "1");
			
		if(null != areaCode) mv.addObject("areaCode", areaCode);
		if(null != sigunguCode) mv.addObject("sigunguCode", sigunguCode);
		if(null != eventStartDate) mv.addObject("eventStartDate", eventStartDate);
		if(null != eventEndDate) mv.addObject("eventEndDate", eventEndDate);
		mv.setViewName("festival/festivalList");
		logger.info(pageNo + ", " + arrange + ", " + areaCode + ", " + sigunguCode + ", " + eventStartDate + ", " + eventEndDate);
		return mv;
	}
	
	// 축제 리스트 불러오기
	@RequestMapping(value = "selectFestivalList.do", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalApi(String pageNo, String arrange, String areaCode, String sigunguCode
			, String eventStartDate, String eventEndDate){ // 페이지 번호, 정렬 기준	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival";
		StringBuilder params = new StringBuilder("?");
		params.append("ServiceKey="+key);
		params.append("&numOfRows=12"); // 한 번에 조회하는 정보 : 12개
		params.append("&pageNo="+ (null != pageNo ? pageNo : "1")); // x페이지
		params.append("&MobileOS=ETC"); // 모바일이 아니므로 etc
		params.append("&MobileApp=planner"); // 앱 이름
		params.append("&arrange=" + (null != arrange ? arrange : "D")); // D 조건(생성일순)으로 정렬 -> C 조건(수정일 순) -> Q(이미지 있는 수정일 순)
		if(null != areaCode) params.append("&areaCode="+areaCode); // 지역코드 : 전체
		if(null != sigunguCode) params.append("&sigunguCode="+sigunguCode); // 지역코드 : 시군구 - 안 따짐
		if(null != eventStartDate) params.append("&eventStartDate="+eventStartDate); // 1월 1일부터
		if(null != eventEndDate) params.append("&eventEndDate="+eventEndDate); // 12월 3일까지
		params.append("&_type=json"); // json으로
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
	public ModelAndView festivalDetail(int contentid, ModelAndView mv) {
		//System.out.println(contentid);
		mv.addObject("contentid", contentid);
		mv.setViewName("festival/festivalDetail");
		return mv;
	}
	
	// 축제 공통정보 조회
	@RequestMapping(value = "festivalDetailCommon.do", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalDetailCommon(int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon";
		StringBuilder params = new StringBuilder("?");
		params.append("ServiceKey="+key);
		//params.append("&numOfRows=1"); // 상세정보 1개
		//params.append("&pageNo="+1); // 1페이지
		params.append("&MobileOS=ETC"); // 모바일이 아니므로 etc
		params.append("&MobileApp=planner"); // 앱 이름
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+15); // 컨텐츠 분류 id
		params.append("&defaultYN=Y"); // 기본정보 조회 여부
		params.append("&firstImageYN=Y"); // 대표이미지 조회
		params.append("&areacodeYN=Y"); // 지역코드 조회
		params.append("&catcodeYN=Y"); // 서비스분류코드 조회
		params.append("&addrinfoYN=Y"); // 주소 조회
		params.append("&mapinfoYN=Y"); // 좌표 조회
		params.append("&overviewYN=Y"); // 개요 조회
		params.append("&_type=json"); // json으로
		
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
	@RequestMapping(value = "festivalDetailIntro.do", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
	public @ResponseBody String festivalDetailIntro(int contentid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro";
		StringBuilder params = new StringBuilder("?");
		params.append("ServiceKey="+key);
		//params.append("&numOfRows=1"); // 상세정보 1개
		//params.append("&pageNo="+1); // 1페이지
		params.append("&MobileOS=ETC"); // 모바일이 아니므로 etc
		params.append("&MobileApp=planner"); // 앱 이름
		params.append("&contentId="+contentid); // 컨텐츠 id
		params.append("&contentTypeId="+15); // 컨텐츠 분류 id
		params.append("&introYN=Y"); // 소개정보 조회
		params.append("&_type=json"); // json으로
		
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
		@RequestMapping(value = "festivalDetailInfo.do", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
		public @ResponseBody String festivalDetailInfo(int contentid){	
			String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailInfo";
			StringBuilder params = new StringBuilder("?");
			params.append("ServiceKey="+key);
			//params.append("&numOfRows=1"); // 상세정보 1개
			//params.append("&pageNo="+1); // 1페이지
			params.append("&MobileOS=ETC"); // 모바일이 아니므로 etc
			params.append("&MobileApp=planner"); // 앱 이름
			params.append("&contentId="+contentid); // 컨텐츠 id
			params.append("&contentTypeId="+15); // 컨텐츠 분류 id
			params.append("&detailYN=Y"); // 반복정보 조회
			params.append("&_type=json"); // json으로
			
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
	@RequestMapping(value = "locationBasedList.do", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
	public @ResponseBody String locationBasedList(double mapx, double mapy, int contenttypeid){	
		String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList";
		StringBuilder params = new StringBuilder("?");
		params.append("ServiceKey="+key);
		//params.append("&numOfRows=10"); // 주변 정보 전체
		//params.append("&pageNo="+1); // 주변 정보 전체
		params.append("&MobileOS=ETC"); // 모바일이 아니므로 etc
		params.append("&MobileApp=planner"); // 앱 이름
		params.append("&contentTypeId="+contenttypeid); // 컨텐츠 분류 id
		params.append("&mapX="+mapx); // x 좌표
		params.append("&mapY="+mapy); // y 좌표
		params.append("&radius=1000"); // 거리 반경(m)
		params.append("&_type=json"); // json으로
		//System.out.println(mapx + ", " + mapy + ", " + contenttypeid);
		
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

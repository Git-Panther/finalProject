package com.kh.planner.common;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.io.IOUtils;

public class JsonParser {
	//private static String serviceKey = "kLZYhnukkkQDzQJ58%2FtZe6IjLUnEn%2FTtuQiqyzSwbiJ8e9SiuyV3xFtgwUu9jpqT33DASyAZb8ST3r3xGD4PJQ%3D%3D";
	//private static String serviceKey = "z7V6sSliIR%2Bo5YnTbwqckgea9o%2BSsyWLHFX5ArEqzUHcsMnTtcIpHydqeqqD1erNziNIyDJ%2Fe7ZNvx6WZkcy0A%3D%3D";
	private static String serviceKey = "EuYOKtjgM9QR9GFYmz2fS0z%2FHXF3%2B80PelXkPL7lRVc2nzcw4dg8OwalAxk2OZu%2F%2BNOmxyqSRqKFXnUg2pGeBg%3D%3D";
	//private static String serviceKey = "%2FgAvK8XbnjBXWVvObqp8BnTgGHmHYtNCjqwZ6tIrI8hUoSi9EzB%2FGpIgrvS3YRnk%2FOCGhlZBGRtJ8XaOVYsV6w%3D%3D";

	public static String getJsonString(String address) {
		String resultStr = "";
		try {
			URL url = new URL(address);
			System.out.println("address : " + address);

			InputStream in = url.openStream();
			ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
			IOUtils.copy(in, bos1);
			in.close();
			bos1.close();

			String mbos = bos1.toString("UTF-8");
			byte[] b = mbos.getBytes("UTF-8");
			resultStr = new String(b, "UTF-8");
			return resultStr;
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("resultStr : " + resultStr );
		return resultStr;
	}

	public static String getContentList(String sidoCode, String sigunguCode, String contenttypeid, String arrange, String pageNo) {
		String resultJson = "";
		String address = "";
		try {
			if(contenttypeid.equals("32")) {
				address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=";
			} else {
				address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=";
			}
			String parameter = "";

			parameter += "&numOfRows=" + 15;
			parameter += "&pageNo=" + pageNo;
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&listYN=" + "Y";
			parameter += "&arrange=" + arrange;
			parameter += "&areaCode=" + sidoCode;
			if (!sigunguCode.equals("-1")) {
				parameter += "&sigunguCode=" + sigunguCode;
			}
			parameter += "&contentTypeId=" + contenttypeid;
			parameter += "&_type= " + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getContentList : =" + resultJson);
			return resultJson;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultJson;
	}

	public static String getLocationBasedList(String contentTypeId, String mapX, String mapY, String pageNo) {
		String resultJson = "";
		try {
			String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=";
			String parameter = "";

			parameter += "&numOfRows=" + 15;
			parameter += "&pageNo=" + pageNo;
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&listYN=" + "Y";
			parameter += "&arrange=" + "A";
			parameter += "&contentTypeId=" + contentTypeId;
			parameter += "&mapX=" + mapX;
			parameter += "&mapY=" + mapY;
			parameter += "&radius=" + "500";
			parameter += "&_type= " + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getLocationBasedList : =" + resultJson);
			return resultJson;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultJson;
	}
	
	public static String getAreaList() {
		String resultJson = "";
		try {
			String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?ServiceKey=";
			String parameter = "";

			parameter += "&numOfRows=" + 17;
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&listYN=" + "Y";
			parameter += "&arrange=" + "A";
			parameter += "&_type= " + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getAreaList : =" + resultJson);
			return resultJson;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultJson;
	}
	
	public static String getSigunguCount(String areaCode) {
		String resultJson = "";
		try {
			String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?serviceKey=";
			String parameter = "";

			parameter += "&numOfRows=" + 0;
			parameter += "&areaCode=" + areaCode;
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&listYN=" + "Y";
			parameter += "&arrange=" + "A";
			parameter += "&_type= " + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getSigunguCount : =" + resultJson);
			return resultJson;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultJson;
	}
	
	public static String getSigunguList(String areaCode, String numOfSigungu) {
		String resultJson = "";
		try {
			String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?serviceKey=";
			String parameter = "";

			parameter += "&numOfRows=" + numOfSigungu;
			parameter += "&areaCode=" + areaCode;
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&listYN=" + "Y";
			parameter += "&arrange=" + "A";
			parameter += "&_type= " + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getSigunguList : =" + resultJson);
			return resultJson;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultJson;
	}
	
	public static String getPopList(String sidoCode, String sigunguCode, String contenttypeid) {
		String resultJson = "";
		String today, p_year, p_month, p_day = "";
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		today = sdf.format(date);
		
		int year = Integer.parseInt(today.substring(0, 4));
		int month = Integer.parseInt(today.substring(4, 6)) - 1;
		int day = Integer.parseInt(today.substring(6, 8));
		if(month == 0) {
			year =- 1;
			month = 12;
		}
		p_year = String.valueOf(year);
		p_month = String.valueOf(month);
		p_day = String.valueOf(day);
		if(p_month.length() < 2) {
			p_month = "0" + p_month;
		}
		if(p_day.length() < 2) {
			p_day = "0" + p_day;
		}
		String dateParam = p_year + p_month + p_day;
		
		
		
		try {
			String address = "";
			if(contenttypeid.equals("15")) {
				address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=";
			} else {
				address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=";
			}
			String parameter = "";

			parameter += "&numOfRows=" + 8;
			if(!sidoCode.equals("-1") && !sigunguCode.equals("-1")) {
				parameter += "&areaCode=" + sidoCode;
				parameter += "&sigunguCode=" + sigunguCode;
			} else if(!sidoCode.equals("-1") && sigunguCode.equals("-1")){
				parameter += "&areaCode=" + sidoCode;
			} else {
				
			}
			parameter += "&contentTypeId=" + contenttypeid;
			parameter += "&arrange=" + "B";
			if(contenttypeid.equals("15")){
				parameter += "&eventStartDate=" + dateParam;
			}
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&_type=" + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getPopAttractionList : =" + resultJson);
			return resultJson;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultJson;
	}

	

}

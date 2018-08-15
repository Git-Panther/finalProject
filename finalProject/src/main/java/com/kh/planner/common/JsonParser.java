package com.kh.planner.common;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;

import org.apache.commons.io.IOUtils;

public class JsonParser {

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

	public static String getSearchStay(String areaCode, String sigunguCode, String arrange, String pageNo) {
		String resultJson = "";
		try {
			String address = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=";
			String serviceKey = "z7V6sSliIR%2Bo5YnTbwqckgea9o%2BSsyWLHFX5ArEqzUHcsMnTtcIpHydqeqqD1erNziNIyDJ%2Fe7ZNvx6WZkcy0A%3D%3D";
			String parameter = "";

			parameter += "&numOfRows=" + 2;
			parameter += "&pageNo=" + pageNo;
			parameter += "&MobileOS=" + "ETC";
			parameter += "&MobileApp=" + "AppTest";
			parameter += "&listYN=" + "Y";
			parameter += "&arrange=" + arrange;
			parameter += "&areaCode=" + areaCode;
			if (Integer.parseInt(sigunguCode) != 0) {
				parameter += "&sigunguCode=" + sigunguCode;
			}
			parameter += "&_type= " + "json";
			address += serviceKey + parameter;

			resultJson = getJsonString(address);
			System.out.println("getSearchStay : =" + resultJson);
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
			String serviceKey = "z7V6sSliIR%2Bo5YnTbwqckgea9o%2BSsyWLHFX5ArEqzUHcsMnTtcIpHydqeqqD1erNziNIyDJ%2Fe7ZNvx6WZkcy0A%3D%3D";
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
			String serviceKey = "z7V6sSliIR%2Bo5YnTbwqckgea9o%2BSsyWLHFX5ArEqzUHcsMnTtcIpHydqeqqD1erNziNIyDJ%2Fe7ZNvx6WZkcy0A%3D%3D";
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
			String serviceKey = "z7V6sSliIR%2Bo5YnTbwqckgea9o%2BSsyWLHFX5ArEqzUHcsMnTtcIpHydqeqqD1erNziNIyDJ%2Fe7ZNvx6WZkcy0A%3D%3D";
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
			String serviceKey = "z7V6sSliIR%2Bo5YnTbwqckgea9o%2BSsyWLHFX5ArEqzUHcsMnTtcIpHydqeqqD1erNziNIyDJ%2Fe7ZNvx6WZkcy0A%3D%3D";
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


	
	

}

package com.kh.planner.common;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.io.IOUtils;

public class JsonManager {
	public static String getJsonString(String path) {
		URL url = null; // 결과를 볼 url
		InputStream in = null; // 바이트를 읽어오기 위해 필요한 인풋 스트림
		ByteArrayOutputStream bos1 = null; // 바이트 출력 스트림
		String result = null; // 바이트 출력 스트림에서 json 문자열을 받을 변수
		try {
			url = new URL(path);
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

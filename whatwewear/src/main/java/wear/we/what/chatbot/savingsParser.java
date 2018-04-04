package wear.we.what.chatbot;

import java.io.BufferedInputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

public class savingsParser { // xml파일에서 원하는 데이터만 parsing해서 가져오는 메소드

	public final static String Savings_URL = "http://api.wunderground.com/api/yourAPI/geolookup/conditions/lang:KR/q/Korea/Seoul.xml";

	public savingsParser() {
	}

	public String apiParserSearch() throws Exception {
		URL url = new URL(getURLParam(null));

		XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
		factory.setNamespaceAware(true);
		XmlPullParser xpp = factory.newPullParser();
		BufferedInputStream bis = new BufferedInputStream(url.openStream());

		xpp.setInput(bis, "UTF-8");

		String tag = null;

		int event_type = xpp.getEventType();

		ArrayList<String> list = new ArrayList<String>();

		String weather = null;
		String temp_c = null;
		String city = null;

		while (event_type != XmlPullParser.END_DOCUMENT) {

			if (event_type == XmlPullParser.START_TAG) {
				tag = xpp.getName();

			} else if (event_type == XmlPullParser.TEXT) { // 태그에 맞는 값을 텍스트로 가져온다!
				if (tag.equals("weather")) {
					weather = xpp.getText();
				}
				if (tag.equals("temp_c")) {
					temp_c = xpp.getText();
				}
				if (tag.equals("local_tz_long")) {
					city = xpp.getText();
				}

			} else if (event_type == XmlPullParser.END_TAG) { // 가져온 값을 리스트에 더해준다!
				tag = xpp.getName();

				if (tag.equals("weather") || tag.equals("temp_c") || tag.equals("local_tz_long")) {

					tag = xpp.getName();
					list.add(weather);
					list.add(temp_c);
					list.add(city);

				} else {
					weather = "";
					temp_c = "";
					city = "";
				}
			}

			event_type = xpp.next();
		}
		list.removeAll(Collections.singleton(""));
		printList(list);
		
		

		city = list.get(0);
		weather = list.get(1);
		temp_c = list.get(2);

		return "현재 날씨는 " + weather + "이며, 기온은 " + temp_c + "℃입니다!";

	}

	public String apiParserTempSearch() throws Exception {
		URL url = new URL(getURLParam(null));

		XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
		factory.setNamespaceAware(true);
		XmlPullParser xpp = factory.newPullParser();
		BufferedInputStream bis = new BufferedInputStream(url.openStream());

		xpp.setInput(bis, "EUC-KR");

		String tag = null;

		int event_type = xpp.getEventType();

		ArrayList<String> list = new ArrayList<String>();

		String temp_c = null;

		while (event_type != XmlPullParser.END_DOCUMENT) {

			if (event_type == XmlPullParser.START_TAG) {
				tag = xpp.getName();

			} else if (event_type == XmlPullParser.TEXT) { // 태그에 맞는 값을 텍스트로 가져온다!

				if (tag.equals("temp_c")) {
					temp_c = xpp.getText();
				}

			} else if (event_type == XmlPullParser.END_TAG) { // 가져온 값을 리스트에 더해준다!
				tag = xpp.getName();

				if (tag.equals("temp_c")) {

					tag = xpp.getName();

					list.add(temp_c);

				} else {
					temp_c = "";
				}
			}

			event_type = xpp.next();
		}
		list.removeAll(Collections.singleton(""));

		temp_c = list.get(0);

		return temp_c;
		
		//printList(list);

	}
	

	 private void printList(ArrayList<String> list) {
	    	
	    	
	    	System.out.println(list);
	    }
	private String getURLParam(String search) { // 날씨 전용
		String url = Savings_URL;
		if (search != null) {
			url = url + "&yadmNm" + search;
		}
		return url;
	}
	
	public static void main(String[] args) throws Exception {
		new savingsParser().apiParserSearch();
	}

}

package wear.we.what.chatbot;

import java.io.BufferedInputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

public class savingsParser { // xml���Ͽ��� ���ϴ� �����͸� parsing�ؼ� �������� �޼ҵ�

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

			} else if (event_type == XmlPullParser.TEXT) { // �±׿� �´� ���� �ؽ�Ʈ�� �����´�!
				if (tag.equals("weather")) {
					weather = xpp.getText();
				}
				if (tag.equals("temp_c")) {
					temp_c = xpp.getText();
				}
				if (tag.equals("local_tz_long")) {
					city = xpp.getText();
				}

			} else if (event_type == XmlPullParser.END_TAG) { // ������ ���� ����Ʈ�� �����ش�!
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

		return "���� ������ " + weather + "�̸�, ����� " + temp_c + "���Դϴ�!";

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

			} else if (event_type == XmlPullParser.TEXT) { // �±׿� �´� ���� �ؽ�Ʈ�� �����´�!

				if (tag.equals("temp_c")) {
					temp_c = xpp.getText();
				}

			} else if (event_type == XmlPullParser.END_TAG) { // ������ ���� ����Ʈ�� �����ش�!
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
	private String getURLParam(String search) { // ���� ����
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

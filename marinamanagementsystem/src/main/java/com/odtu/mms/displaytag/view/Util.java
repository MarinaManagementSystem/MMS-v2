package com.odtu.mms.displaytag.view;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class Util {
	public static String html2string(String value) {
		Document doc = Jsoup.parse(value);
    	doc.select("br").prepend("br2n");
    	doc.select("div").prepend("br2n");
    	return doc.text().replaceAll("br2n", "\n");    	
	}
}

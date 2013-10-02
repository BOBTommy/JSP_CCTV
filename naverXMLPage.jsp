<%	request.setCharacterEncoding("UTF-8");
	try{
	String query = request.getParameter("query");
	query = new String(query.getBytes("8859_1"), "UTF-8");
	URL xmlURL = new URL("http://map.naver.com/api/geocode.php?key=f98d021402efd46e873691f507de1fb1&encoding=utf-8&query="+query);
	HttpURLConnection xmlCon = (HttpURLConnection) xmlURL.openConnection();
	xmlCon.setDoOutput(true);
	xmlCon.setRequestMethod("POST");
	int len = xmlCon.getContentLength();
	String inputStr ="";
	if(len > 0){
		BufferedReader br = new BufferedReader(new InputStreamReader(xmlCon.getInputStream(),"UTF-8"));
		int i = len;
		String inputLine;
		while( (inputLine = br.readLine()) != null ){
			inputStr += inputLine;
		}
		br.close();
		out.print(inputStr);
	}else
	{
		out.println("There is no connection");
	}
	}catch(Exception e){}
%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.StringTokenizer" %>

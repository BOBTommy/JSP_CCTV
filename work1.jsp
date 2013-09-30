<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.StringTokenizer" %>
<%
	try{
	String query = "서울마포구상암동1601";
	query = new String(query.getBytes(),"EUC-KR");
	URL xmlURL = new URL("http://map.naver.com/api/geocode.php?key=f98d021402efd46e873691f507de1fb1&encoding=euc-kr&query="+query);
	HttpURLConnection xmlCon = (HttpURLConnection) xmlURL.openConnection();
	xmlCon.setDoOutput(true);
	xmlCon.setRequestMethod("POST");

	int len = xmlCon.getContentLength();
	String inputStr ="";
	if(len > 0){
		BufferedReader br = new BufferedReader(new InputStreamReader(xmlCon.getInputStream(),"EUC-KR"));
		int i = len;
		String inputLine;
		while( (inputLine = br.readLine()) != null ){
			inputStr += inputLine;
		}
		br.close();
	}else
	{
		out.println("There is no connection");
	}
	
	String x1="";
	String y1="";

	if( inputStr.indexOf("</item>") > -1)
	{
		x1 = inputStr.substring( inputStr.indexOf("<x>")+3, inputStr.indexOf("</x>") );
		y1 = inputStr.substring( inputStr.indexOf("<y>")+3, inputStr.indexOf("</y>") );
		//out.println("x1 : "+x1+", y1 : "+y1);
	}else{
		out.println("We cannot find location");
	}
		
	}catch(Exception e){}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>CCTV Map mapping using Naver OPEN API</title>
		<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=f98d021402efd46e873691f507de1fb1"></script>
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js" ></script>

		<script type="text/javascript">
			try {document.execCommand('BackgroundImageCache', false, true);} catch(e) {}

			function checkForm(text){
				if(text == ""){
					return true;
				}
				else{
					return false;
				}
			}

			function getCctvText(){
				var searchText = $("#cctvTaxi").val();
				alert(searchText);
				if(checkForm(searchText)){
					alert("검색어를 입력해 주세요.");
					return false;
				}
			}

			function tmp(){
				alert("hello");
			}

			function getNaverText(){
				var searchText = $("#naverMap").val();
				if(checkForm(searchText)){
					alert("검색어를 입력해 주세요.");
					return false;
				}

				$.get("http://openapi.map.naver.com/api/geocode.php?key=f98d021402efd46e873691f507de1fb1&coord=latlng&query=서울시마포구상암동1603",
					function(data,status){
					alert("Data :" + data + " \nStatus: " + status);
				});

			/*	$.ajax({

					uri : "http://openapi.map.naver.com/api/geocode.php?key=f98d021402efd46e873691f507de1fb1&query=경기도성남시정자1동25-1"
					//url : "http://openapi.map.naver.com/api/geocode.php?key=f98d021402efd46e873691f507de1fb1&&coord=latlng&query=서울시마포구상암동1601"
					, type : "GET"
					, dataType : "xml"
					, beforeSend:function(x){
						if(x && x.overrideMimeType) {
							x.overrideMimeType("application/xml;charset=UTF-8");
						}
					}
					, success : function(result){
						alert("Success");
						//var item = result.getElementsByTagName("item");
					}
					, error : function(x,e){
						alert(e);
					}

				});*/
			}

			function getXMLHttpRequest(){
				var addr = $("addr").val();
			}
		</script>
		<link href="StyleSheet.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<table>
			<tr>
				<td id="topTable"><input type="button" id="addCCTV" value="CCTV 추가" /></td>
				<td id="topTable"><input type="button" id="addTaxi" value="택시 추가" /></td>
				<td id="topTable"><input type="button" id="modTaxi" value="택시 수정" /></td>
			</tr>
		</table>

		<table>
		<tr>
			<td>CCTV / 택시 검색 <input type="text" id='cctvTaxi' value="" /></td>
			<td><form name="cctvForm" method="post" action="" onsubmit="getCctvText(); return false;" >
				<input type="submit" id="searchTextBtn" value="검색" /></form></td>
		</tr>
		<tr>
			<td><p>네이버 지도 검색 <input type="text" id="naverMap" value = "" /></p></td>
			<td><form name="naverForm" method="post" action="" onsubmit="getNaverText(); return false;">
				<input type="submit" id="searchMapBtn" value="검색" /></form></td>
		</tr>
	</table>

		<script type="text/javascript" charset="utf-8">
			/*function handleSearchTextBtn(e){
				var text = document.getElementById("cctvTaxi");
				if(text == null)
					alert("Object is null");
				if(text.value == "")
					alert("Please enter a search text");
				else
					alert(text.value);
			}

			function handleMapSearchBtn(e){
				var text = document.getElementById("naverMap");
				if(text == null)
					alert("Object is null");
				if(text.value == "")
					alert("Please enter a search text");
				else
					alert(text.value);
			}*/
		</script>

		<div id ="map"></div>
			<script>
				var oPoint = new nhn.api.map.LatLng(37.5010226, 127.0396037);
				nhn.api.map.setDefaultPoint('LatLng');
				oMap = new nhn.api.map.Map('map', {
					point: oPoint,
					zoom: 10,
					enableWheelZoom: true,
					enableDragPan: true,
					enableDblClickZoom: false,
					mapMode: 0,
					activateTrafficMap: false,
					activateBicycleMap: false,
					minMaxLevel: [1, 14],
					size: new nhn.api.map.Size(800, 400)
				});
			</script>
	</body>
</html>
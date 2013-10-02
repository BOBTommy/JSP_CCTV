<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
					alert("No input");
					return false;
				}
			}

			function getNaverText(){
				var searchText = $("#naverMap").val();
				if(checkForm(searchText)){
					alert("No input");
					return false;
				}
				
				alert("naverXMLPage.jsp?query=" + searchText);
				
				$.ajax({
					
					url : "naverXMLPage.jsp?query=" + searchText 
					, type : "GET"
					, dataType : "xml"
					, success : function(result){
						$(result).find('geocode').each(function(){
							var total = $(this).find("total").text();
							alert("TOTAL : " + total);
						});
					}
					, error : function(x,e){
						//alert(result);
						alert(e);
					}

				});
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
				<td id="topTable"><input type="button" id="addTaxi" value="TAXI 추가" /></td>
				<td id="topTable"><input type="button" id="modTaxi" value="TAXI 수정" /></td>
			</tr>
		</table>

		<table>
		<tr>
			<td>CCTV / TAXI <input type="text" id='cctvTaxi' value="" /></td>
			<td><form name="cctvForm" method="post" action="" onsubmit="getCctvText(); return false;" >
				<input type="submit" id="searchTextBtn" value="검색" /></form></td>
		</tr>
		<tr>
			<td><p>네이버 지도 검색 <input type="text" id="naverMap" value = "" /></p></td>
			<td><form name="naverForm" method="post" action="" onsubmit="getNaverText(); return false;">
				<input type="submit" id="searchMapBtn" value="검색" /></form></td>
		</tr>
	</table>

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

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>CCTV Map mapping using Naver OPEN API</title>
		<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=f98d021402efd46e873691f507de1fb1"></script>
		<script type="text/javascript" src="/common_adm/js/jquery-1.9.1.min.js" ></script>
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
			<td><form><input type="button" id="searchTextBtn" value="검색" onclick='handleSearchTextBtn()'></form></td>
		</tr>
		<tr>
			<td><p>네이버 지도 검색 <input type="text" id="naverMap" value = "" /></p></td>
			<td><form><input type="button" id="searchMapBtn" value="검색" onclick='handleMapSearchBtn()'></form></td>
		</tr>
	</table>

		<script type="text/javascript" charset="utf-8">
			function handleSearchTextBtn(e){
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
			}
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
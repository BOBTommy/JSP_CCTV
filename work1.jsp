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
			
			var naverObjects = [];
			var cctvObjects = [];
			var listNum = 0;
			var markerNum = 0;
			var oSize = new nhn.api.map.Size(28, 37);
			var oOffset = new nhn.api.map.Size(14, 37);
			var iCon = new nhn.api.map.Icon('cctv.png',oSize, oOffset);
			
			//현재 CCTV 추가 상황인지 아닌지 체크 하는 flag
			var cctvAdditionFlag = false;
			
			
			var cctvMarker =new nhn.api.map.Marker(iCon);
			var mapInfoWindow = new nhn.api.map.InfoWindow();
			mapInfoWindow.setVisible(false);
			
			//Naver Object : 네이버 검색 결과를 담고 있는 Object
			function NaverObject(addr, x, y){
				this.addr = addr;
				this.x = x;
				this.y = y;
			}
			
			NaverObject.prototype.getAddr = function() {return this.addr;}
			NaverObject.prototype.getX = function() {return Number(this.x);}
			NaverObject.prototype.getY = function() {return Number(this.y);}
			
			//CCTV Object : CCTV 정보를 담고 있음 마커도 한개씩
			function CCTV(marker, num, addr, adminName, adminPhone, coverage, coPoint){
				this.marker = marker;
				this.num = num;
				this.addr = addr;
				this.adminName = adminName;
				this.adminPhone = adminPhone;
				this.coverage = coverage;
				this.coPoint = coPoint;
			}
			
			CCTV.prototype.getMarker = function() {return this.marker;}
			CCTV.prototype.getNum = function() {return this.num;}
			CCTV.prototype.getAddr = function() {return this.addr;}
			CCTV.prototype.getAdminName = function() {return this.adminName;}
			CCTV.prototype.getAdminPhone = function() {return this.adminPhone;}
			CCTV.prototype.getCoverage = function() {return this.coverage;}
			CCTV.prototype.getPoint = function() {return this.coPoint;}
			
			$(document).ready(function(){
				
				$('#addCCTV').bind("click", function(){
					addCCTVPopUp();
				});
					
				oMap.attach("click",clickEvent);
				oMap.addOverlay(mapInfoWindow);
				
				$("#additionFlag").text("CCTV 추가모드 : Disable");
				
			});
			
						
			function checkForm(text){
				if(text == ""){
					return true;
				}
				else{
					return false;
				}
			}
			
			function removeBlank(text){
				var returnString = text;
				returnString = returnString.replace(/(^\s*)|(\s*$)/, '');
				return returnString;
			}

			function getCctvText(){
				var searchText = $("#cctvTaxi").val();
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
				
				searchText = removeBlank(searchText);
				
				listNum = 0;
				//alert("naverXMLPage.jsp?query=" + searchText);
				var numTotal;
				$.ajax({
					
					url : "naverXMLPage.jsp?query=" + searchText 
					, type : "GET"
					, dataType : "xml"
					, success : function(result){
						$(result).find('geocode').each(function(){
							var total = $(this).find("total").text();
							numTotal = Number(total);
							$('.Result_Show_text').show();
							
							if( $("#search_result").index() != 0 ){
								$("#search_result").empty();
								naverObjects = [];
							}
							
							if(numTotal == 0){
								$("#search_result").append("<li>검색 결과가 없습니다.</li>");
								return;
							}
							$(this).find('item').each(function(){
								var addr = $(this).find('address').text();
								var x = $(this).find('point').find('x').text();
								var y = $(this).find('point').find('y').text();
								naverObjects.push(new NaverObject(addr, Number(x), Number(y)));
								//$("#search_result").append("<li><a href=\"\">"+addr+"</a></li>");
							});
							
							for(var i =0 ; i < naverObjects.length; i++){
								$("#search_result").append("<li><a id=\"list"+i+"\" href=\"#\">"+naverObjects[i].getAddr()+"</a></li>");	
							}
							
							listNum = naverObjects.length;
							
					//		for(var i=0; i<listNum; i++){
					//			$('#list'+i).on("click",moveMapXY(naverObjects[i]));
					//		}
							addListener();
							
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
			
			function addCCTVPopUp(){
				if(cctvAdditionFlag == false){
					$("#additionFlag").text("CCTV 추가모드 : Enable");
					cctvAdditionFlag = true;
					$("#addCCTV").prop('value','추가 중지');
				}else if(cctvAdditionFlag == true){
					$("#additionFlag").text("CCTV 추가모드 : Disable");
					cctvAdditionFlag = false;
					$("#addCCTV").prop('value','CCTV 추가');
				}
			}
			
			var clickPoint;
			
			var clickEvent = function(oCustomEvent){
				
				var pos = oCustomEvent.point;
				var oTarget = oCustomEvent.target;
				
				if(oTarget instanceof nhn.api.map.Marker){
					for(var i=0; i<markerNum; i++){
						if( (cctvObjects[i].getMarker().getPoint().getX() == oTarget.getPoint().getX()) &&
							(cctvObjects[i].getMarker().getPoint().getY() == oTarget.getPoint().getY()) ){
							mapInfoWindow.setContent('CCTV NUM : ' + cctvObjects[i].getNum() +'<br>'
													+ 'CCTV ADDR : ' + cctvObjects[i].getAddr() + '<br>'
													+ 'Admin Name : ' + cctvObjects[i].getAdminName() + '<br>'
													+ 'Admin Contact : ' + cctvObjects[i].getAdminPhone() + '<br>'
													+ 'CCTV Coverage(m) : ' + cctvObjects[i].getCoverage());
							mapInfoWindow.setPoint(oTarget.getPoint());
							mapInfoWindow.setVisible(true);
							
							break;
						}
					}
					return;
				}	
				
				if(cctvAdditionFlag == false)
					return;
					
				clickPoint = new nhn.api.map.TM128(pos.getX(),pos.getY());
				
				var flag;
				flag = "width=500, ";
				flag += "height=420";
				window.open('cctvPopUp.jsp',"CCTV 추가", flag);
				
			}

			function alert2(){
				alert(clickPoint);
			}
			
			function makeMarker(num, addr, adminName, adminPhone, coverage){
				var oMarker = new nhn.api.map.Marker(iCon);
				oMarker.setPoint(clickPoint);
				cctvObjects.push(new CCTV(oMarker,num,addr,adminName,adminPhone,coverage,clickPoint));
				oMap.addOverlay(cctvObjects[markerNum].getMarker());
				markerNum++;
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
				<td id="topTable"><label id="additionFlag"></label>
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

		<div id ="map">
			<script>
			
				var oPoint = new nhn.api.map.TM128(315981, 546567);
				nhn.api.map.setDefaultPoint('TM128');
				var oMap = new nhn.api.map.Map('map', {
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
				
				
				function addListener(){
					for(var i=0; i<listNum; i++){
						$('#list'+i).bind("click", { param1 : naverObjects[i] } ,function(event) {
							var naverObj = event.data.param1;
							var movePoint = new nhn.api.map.TM128(naverObj.getX(), naverObj.getY());
							oMap.setCenter(movePoint);	//맵 위치 이동
							
							//cctvMarker.setPoint(movePoint);	//마커표시
							//oMap.addOverlay(cctvMarker);
							
							//var oLabel = new nhn.api.map.MarkerLabel();
							//oMap.addOverlay(oLabel);
							//oLabel.setVisible(true, cctvMarker);
						});
					}
				}
			</script>
		</div>
		<h3 class="Result_Show_text">네이버 지도 검색 결과</h3>
		<ol id="search_result" class="rounded-list">
		</ol>
	</body>
</html>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
        <script type="text/javascript" src="/common_adm/js/jquery-1.9.1.min.js" ></script>
        <script type="text/javascript">
        $(document).ready(function(){
         $("#addr").focus();
         oMap.attach("click", function(oEvent){
          $("#posX").text(oEvent.point.x);
          $("#posY").text(oEvent.point.y);
         });
        });
            try {document.execCommand('BackgroundImageCache', false, true);} catch(e) {}
            
            
            function getPosList(){
             var addr = $("#addr").val();
             if(addr == ""){
              alert("주소를 입력해 주세요");
              $("#addr").focus();
              return false;
             }
             $.ajax({
              url : "http://openapi.map.naver.com/api/geocode.php"
              , type : "GET"
              , data : "key=f98d021402efd46e873691f507de1fb1&&coord=latlng&query=" + addr
              , dataType : "xml"
              , success : function(result){
               var resultItem = result.getElementsByTagName("total");
               //alert(resultItem[0].firstChild.nodeValue);
               //alert(result.getElementsByTagName("item").length)
               var str = "";
               var items = result.getElementsByTagName("item");
               for(i = 0; i < items.length; i++){
                var item = items[i];
                var x = item.getElementsByTagName("x")[0].firstChild.nodeValue;
                var y = item.getElementsByTagName("y")[0].firstChild.nodeValue;
                str += "<li>";
                str += "<a href='#' onclick='move("+x+ "," +y+");return false;'>";
                str += item.getElementsByTagName("address")[0].firstChild.nodeValue;
                str+= "</a>";
                str += "</li>";
               }
               if(items.length > 0 ){
                $("#posList").html("<ul>" + str + "</ul>");
                
               }
              }
             });
             //http://openapi.map.naver.com/api/geocode.php?key=1de38e0c0c2075ea845b60b8e31bd83c&query=%EA%B2%BD%EA%B8%B0%EB%8F%84%20%EC%95%88%EC%96%91%EC%8B%9C%20%EC%95%88%EC%96%913%EB%8F%99
            }
            function move(x, y ){
             var oPoint = new nhn.api.map.LatLng(y, x);
             oMap.setCenter(oPoint);
            }
            function moveSetPos(){
             var x = $("#posX").text();
             var y = $("#posY").text();
             move(x, y );
            }
            
            
        </script>
        <script type="text/javascript" src="</script'>http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=f98d021402efd46e873691f507de1fb1"></script>
        <style>
           
        </style>
</head>
<body>
<div id="frm" style="clear:both;margin:10px;">
    <form name="form1" method="post" action="" onsubmit="getPosList(); return false;">
        <strong>주소</strong> : <input type="text" name="addr" id="addr" maxlength="200" style="width: 300px;" title="주소입력" />
        <input type="submit" value="검색" title="검색" />
        <span style="margin-left:30px;">
            <span id="posY" style="width:50px; border:2px solid #333;"></span>
            <span id="posX" style="width:50px; border:2px solid #333;"></span> 
            <a href="#" onclick="moveSetPos(); return false;">설정위치 이동</a>
        </span>
    </form>
</div>
<div id="posList" style="border:1px solid #ccc; width:300px; height:400px; float:left;overflow:auto; "></div>
<div id = "testMap" style="border:1px solid #000; width:500px; height:400px; margin-left:10px; float:left; "></div>
 
        <script type="text/javascript">
            var oPoint = new nhn.api.map.LatLng(37.29909, 126.9912);
            nhn.api.map.setDefaultPoint('LatLng');
            oMap = new nhn.api.map.Map('testMap' ,{
                        point : oPoint,
                        zoom : 10,
                        enableWheelZoom : true,
                        enableDragPan : true,
                        enableDblClickZoom : false,
                        mapMode : 0,
                        activateTrafficMap : false,
                        activateBicycleMap : false,
                        minMaxLevel : [ 1, 14 ],
                        size : new nhn.api.map.Size(500, 400)
                    });
        </script>
</body>
</html>
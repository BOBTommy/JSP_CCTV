<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>CCTV Add Page</title>
		<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js" ></script>
		<script type="text/javascript">
			function saveObject(){
				var flag = validationCheck();
				
				if(flag){
					return;
				}
				
				var num = $("#num").val();
				var addr = $("#addr").val();
				var adminName = $("#adminName").val();
				var adminPhone = $("#adminPhone").val();
				var coverage = $("#coverage").val();
				
				window.opener.alert2();
			}
			
			function validationCheck(){
				var num = $("#num").val();
				var addr = $("#addr").val();
				var adminName = $("#adminName").val();
				var adminPhone = $("#adminPhone").val();
				var coverage = $("#coverage").val();
				
				if(num.length == 0){
					alert("Num 필드를 입력해주세요");
					return true;
				}else if(addr.length == 0){
					alert("Address 필드를 입력해주세요");
					return true;
				}else if(adminName.length == 0){
					alert("Admin Name 필드를 입력해주세요");
					return true;
				}else if(adminPhone.length == 0){
					alert("Admin Phone 필드를 입력해주세요");
					return true;
				}else if(coverage.length == 0 ){
					alert("Coverage 필드를 입력해주세요");
					return true;
				}else{
					return false;
				}
				
			}
		</script>
		<link href="StyleSheet.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div id="addObject">
			<h1>add a CCTV Object</h1>
			<form action="" method="post" onsubmit="saveObject(); return false;">
				<fieldset>
					<label for="num">NUM:</label>
					<input type="text" id="num" class="commentBox" placeholder="CCTV Number" />
					<br>
					<label for="addr">Address:</label>
					<input type="text" id="addr" class="commentBox" placeholder="CCTV Address" />
					<br>
					<label for="adminName">Admin Name:</label>
					<input type="text" id="adminName" class="commentBox" placeholder="CCTV AdminName" />
					<br>
					<label for="adminPhone">Admin Phone:</label>
					<input type="text" id="adminPhone" class="commentBox" placeholder="CCTV Administrator Contact Number" />
					<br>
					<label for="coverage">Coverage:</label>
					<input type="text" id="coverage" class="commentBox" placeholder="CCTV coverage" />
					<br><br>
					
					<input type="submit" id="addSave" value="Save" />
					
				</fieldset>
			</form>
		</div>	
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
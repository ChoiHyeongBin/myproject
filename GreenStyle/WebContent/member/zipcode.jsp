<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#box { width:280px; border:1px solid black; padding:5px; text-align:center; }
	#zip { width:260px; height:30px; margin:5px; }
	#addrDetail { width:180px; height:30px; margin:5px; }
</style>
<script>
	function zipApply() {
		var zipCombo = document.frmZip.zip.value;
		var addrDetail = document.frmZip.addrDetail.value;

		if (zipCombo == "" || addrDetail == "") {
			alert("원하는 주소를 선택하고, 상세주소를 입력하세요.");
			return false;
		}

		var zip = zipCombo.substring(0, 5);	// 우편번호 부분 추출
		var addr = zipCombo.substring(6);	// 주소 부분 추출

		opener.frmJoin.zip.value = zip;
		opener.frmJoin.addr1.value = addr;
		opener.frmJoin.addr2.value = addrDetail;

		self.close();
	}
</script>
</head>
<body>
<h2>우편번호 찾기</h2>
<form name="frmZip">
<div id="box">
	<select name="zip" id="zip" onchange="this.form.addrDetail.focus();">
		<option value=""> - 주소 선택 - </option>
		<option value="12345 서울시 강남구 삼성동">[12345] 서울시 강남구 삼성동</option>
		<option value="12346 서울시 강남구 삼성1동">[12346] 서울시 강남구 삼성1동</option>
		<option value="12347 서울시 강남구 삼성2동">[12347] 서울시 강남구 삼성2동</option>
		<option value="12348 서울시 강남구 삼성3동">[12348] 서울시 강남구 삼성3동</option>
		<option value="12349 서울시 강남구 삼성4동">[12349] 서울시 강남구 삼성4동</option>
		<option value="12350 서울시 강남구 삼성5동">[12350] 서울시 강남구 삼성5동</option>
		<option value="12351 서울시 강남구 삼성6동">[12351] 서울시 강남구 삼성6동 장연빌딩 6층 604호</option>
	</select><br />
	상세 주소 :
	<input type="text" name="addrDetail" id="addrDetail" />
</div>
<p align="center">
	<input type="submit" value="적 용" onclick="zipApply();" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="닫 기" onclick="self.close();" />
</p>
</form>
</body>
</html>
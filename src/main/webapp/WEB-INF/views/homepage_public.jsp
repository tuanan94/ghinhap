
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ghi nháp - Trang chủ</title>
<script src="./resources/script/tagcanvas.min.js" type="text/javascript"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./resources/css/custom.css">
<script src="./resources/script/homepageScript.js" type="text/javascript"></script>



</head>
<body>

	<div class="input-group">
		<span class="input-group-addon" id="basic-addon1">ghinhap.com/</span>
		<input id="urlInput" type="text" class="form-control"
			placeholder="Hãy nhập tên cho note của bạn"
			aria-describedby="basic-addon1" maxlength="200"> <span
			class="input-group-btn">
			<button id="btnGo" class="btn btn-default" type="button" onclick="gotoUrl()">Go!</button>
		</span>
	</div>
	<div id="canvas_hint" >
		<p style="font-style: italic; color: #336699;">Các nháp không khóa được dùng gần đây...</p>
	</div>
	
</body>
</html>
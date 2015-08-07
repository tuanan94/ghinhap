
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
<script type="text/javascript">
	window.onload = function() {

	};
	$(document).ready(function() {
		var canvasData;
		getCanvasData();
		$("#urlInput").bind("keypress", {}, keypressInBox);
	});

	function getCanvasData() {
		$.ajax({
			type : "POST",
			url : "ajax/getCanvasContent",
			dataType : 'json',
			success : function(data) {
				canvasData = data;
				buildCanvas();
				startCanvas();
			},
			error : function(data) {

				alert('fail');
			}
		});
	}

	function buildCanvas(data) {
		var elementString = "";
		for (i = 0; i < canvasData.length; i++) {

			elementString += "'"
					+ '<li><a href="http://ghinhap.com/'+canvasData[i]+'" target="_blank">'
					+ canvasData[i] + "</a></li>'";
		}

		var htmlString = '<div id="myCanvasContainer">'
				+ '<canvas width="300" height="300" id="myCanvas">'
				+ '<p>Anything in here will be replaced on browsers that support the'
				+ '	canvas element</p>'
				+ '</canvas>'
				+ '</div>'
				+ '<div id="tags">'
				+ '<ul>'
				+ elementString
				+ '<li><a href="http://www.google.com" target="_blank">Public</a></li>'
				+ '</ul>' + '</div>';
		$(htmlString).appendTo("body");
	}
	function startCanvas() {
		try {
			TagCanvas.Start('myCanvas', 'tags', {
				textColour : '#C3C5C4',
				outlineColour : '#F9F9AC',
				reverse : true,
				depth : 0.8,
				maxSpeed : 0.03
			});
		} catch (e) {
			// something went wrong, hide the canvas container
			document.getElementById('myCanvasContainer').style.display = 'none';
		}
	}

	function gotoUrl() {
		var url = $('#urlInput').val();
		if (url === null || url === '') {
			return;
		}
		url = 'http://ghinhap.com/' + url;
		window.location = url;
	}

	function keypressInBox(e) {
	    var code = (e.keyCode ? e.keyCode : e.which);
	    if (code == 13) { //Enter keycode                        
	        e.preventDefault();
	       	$('#btnGo').click();
	    }
	};
</script>



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
</body>
</html>
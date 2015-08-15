<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Ghi nháp</title>

<link rel="stylesheet" type="text/css" href="http://localhost:8080/ghichu/resources/css/custom.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://localhost:8080/ghichu/resources/src/ace.js"></script>
<script type="text/javascript" src="http://localhost:8080/ghichu/resources/script/setInputColor.js"></script>
<script type="text/javascript" src="http://localhost:8080/ghichu/resources/script/saveFunction.js"></script>
<script type="text/javascript" src="http://localhost:8080/ghichu/resources/script/functions.js"></script>
<script type="text/javascript" src="http://localhost:8080/ghichu/resources/src/ext-language_tools.js"></script>

</head>
<body>
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img id="imglock" onclick="lockClick()" alt="lock"
			src="http://ghinhap.com/resources/img/unlock.png" width="20px" height="20px" /> <img
			id="imgUnlock" onclick="unLockClick()" alt="unlock"
			src="http://ghinhap.com/resources/img/lock.png" width="20px" height="20px" /> <select
			id="typeSelector" onchange="typeChange()">
			<option value="0">Text-mặc định</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<pre id="editor" onpaste="saveImediately()" oncut="saveImediately()"></pre>

	<script>
		//set up for editor
		var isFirst = true;
		var editor = ace.edit("editor");
		var intervalId;
		editorInit(editor);
		//set up when document ready
		$(document).ready(function() {
			setInitParam('${contents}', '${type}', '${isLock}');
		});

		$.sendContentToServer = function sendContentToServer() {
			var type = document.getElementById('typeSelector').value;
			requestUpdateContent(editor.getValue(), '${noteid}', type);
			window.clearInterval(intervalId);
		}

		function lockClick() {
			requestLock('${noteid}');
		}
		function unLockClick() {
			requestUnlock('${noteid}');
		}
		function saveImediately() {
			var type = document.getElementById('typeSelector').value;
			$.ajax({
				type : "POST",
				url : hostName+"ajax/savecontent",
				data : {
					contents : editor.getValue(),
					noteid : '${noteid}',
					type : type

				},
				success : function(data) {
					setInputColor('green');
				},
				error : function(data) {
					setInputColor('red');
				}
			});
		}
	</script>
</body>
</html>

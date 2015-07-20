
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Editor</title>
<link rel="stylesheet" type="text/css" href="./resources/css/custom.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src=./resources/mousetrap.min.js></script>
<script src="./resources/src/ace.js"></script>

</head>
<body>
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img id="imglock" alt="lock" src="./resources/img/unlock.png" width="20px" height="20px">
		
		<select id="typeSelector" onchange="typeChange()">
			<option value="0">Text-default</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<pre id="editor"></pre>
	<!-- load ace -->
	<script>
		//set up for editor
		var isFirst = true;
		var editor = ace.edit("editor");
		var intervalId;
		editor.setTheme("ace/theme/tomorrow");
		editor.session.setMode("ace/mode/html");
		editor.setAutoScrollEditorIntoView(true);
		editor.setOptions({
			maxLines : Infinity
		});
		editor.on('input', function() {
			if (isFirst) {
				isFirst = false;
				return;
			}
			setInputColor('red');
			window.clearInterval(intervalId);
			intervalId = (setTime(3000));
		});
		//New
		editor.onmousedown = function() {
			paste.style.display = 'block';
		};

		editor.onmouseup = function() {
			setTimeout(function() {
				paste.style.display = 'none';
			}, 0);
		};
		//New
		editor.oncontextmenu = function() {
			paste.setSelectionRange(0, 0);
		};
		//set up when document ready
		$(document).ready(function() {
			console.log("ready!");
			editor.setValue('${contents}', 1);
			setEditorType('${type}');
			setInputColor('green');
		});
		function convertString(raw) {
			raw.replace("Microsoft", "W3Schools");
			return raw;
		}

		//set Time for Auto send function
		function setTime(time) {
			return window.setInterval($.sendContentToServer, time);
		}
		$.sendContentToServer = function sendContentToServer() {
			console.log("send content to server");
			setInputColor('orange');
			$.ajax({
				type : "POST",
				url : "ajax/savecontent",
				data : {
					contents : editor.getValue(),
					noteid : '${noteid}',
					type : document.getElementById('typeSelector').value

				},
				success : function(data) {
					setInputColor('green');
				},
				error : function(data) {
					setInputColor('red');
				}
			});
			window.clearInterval(intervalId);
		}
		//setTime for change Type
		function typeChange() {
			setInputColor('red');
			window.clearInterval(intervalId);
			intervalId = (setTime(3000));
			setEditorType(document.getElementById('typeSelector').value);
		}
		//set Editor Type
		function setEditorType(value) {
			switch (value) {
			case '0':
				editor.session.setMode("ace/mode/text");

				break;
			case '1':
				editor.session.setMode("ace/mode/html");
				break;
			case '2':
				editor.session.setMode("ace/mode/java");
				break;
			case '3':
				editor.session.setMode("ace/mode/csharp");
				break;
			case '4':
				editor.session.setMode("ace/mode/objectivec");
				break;
			case '5':
				editor.session.setMode("ace/mode/javascript");
				break;			
			}
			$('#typeSelector option').eq(value).prop('selected', true);
		}
	</script>

	<script type="text/javascript"
		src="./resources/script/setInputColor.js"></script>
	<script type="text/javascript" src="./resources/script/saveFunction.js"></script>
</body>
</html>

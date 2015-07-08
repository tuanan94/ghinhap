
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
		<select id="typeSelector" onchange="typeChange()">
			<option value="0">Text-default</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
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
		//set up when document ready
		$(document).ready(function() {
			console.log("ready!");
			editor.setValue('${contents}', 1);
			setEditorType('${type}');
			setInputColor('green');
		});
	
		
	</script>
	<script type="text/javascript" src="./resources/script/timing.js"></script>
	<script type="text/javascript" src="./resources/script/setInputColor.js"></script>
	<script type="text/javascript" src="./resources/script/saveFunction.js"></script>
</body>
</html>

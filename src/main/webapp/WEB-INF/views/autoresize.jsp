
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
		//set Time for Auto send function
		function setTime(time) {
			return window.setInterval($.sendContentToServer,time);
		}
		$.sendContentToServer = function sendContentToServer(){
			console.log("send content to server");
			setInputColor('orange');
			$.ajax({
				type : "POST",
				url : "ajax/savecontent",
				data : {
					contents : editor.getValue(),
					noteid : "${noteid}",
					type : document.getElementById("typeSelector").value,

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
			}
			$('#typeSelector option').eq(value).prop('selected', true);
		}
		//set Input Color
		function setInputColor(color) {
			switch (color) {
			case 'green':
				var colorBox = document.querySelector(".color-box");
				colorBox.style.background = '#00CC00';
				break;
			case 'red':
				var colorBox = document.querySelector(".color-box");
				colorBox.style.background = '#FF0000';
				break;
			case 'orange':
				var colorBox = document.querySelector(".color-box");
				colorBox.style.background = '#FF9900';
				break;
			}
		}
		//Set Ctrl + S function
		$.ctrl = function(key, callback, args) {
		    var isCtrl = false;
		    $(document).keydown(function(e) {
		        if(!args) args=[]; // IE barks when args is null
		        
		        if(e.ctrlKey) isCtrl = true;
		        if(e.keyCode == key.charCodeAt(0) && isCtrl) {
		            callback.apply(this, args);
		            return false;
		        }
		    }).keyup(function(e) {
		        if(e.ctrlKey) isCtrl = false;
		    });        
		};
		$.ctrl('S',function(){
			window.clearInterval(intervalId);
			intervalId = (setTime(1000));
		});
	</script>

</body>
</html>

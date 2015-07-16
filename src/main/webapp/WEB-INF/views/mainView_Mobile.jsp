<!DOCTYPE html>
<html lang="en">
<head>
<title>JQuery LinedTextArea Demo</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
<!--320-->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<script src="./resources/jquery-linedtextarea.js"></script>
<link href="./resources/jquery-linedtextarea.css" type="text/css"
	rel="stylesheet" />
<style type="text/css">
</style>
<style type="text/css">
textarea {
	width: 100%;
	min-height: 100%;
	word-wrap: break-word;
	height: 300%;
	font-size: 100%;
}
</style>
<link rel="stylesheet" type="text/css" href="./resources/css/custom.css">
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
	<textarea class="lined" rows="200" cols="60">JavaScript was originally developed by Brendan 
Eich of Netscape under the name Mocha, 
which was later renamed to LiveScript, 
and finally to JavaScript. 

The change of name from LiveScript to JavaScript roughly 
coincided with Netscape adding support for 
Java technology in its Netscape Navigator 
web browser. 

JavaScript was first introduced 
and deployed in the Netscape browser version 
2.0B3 in December 1995. 

The naming has caused confusion, giving the 
impression that the language is a spin-off of Java, 
and it has been characterized by many as a 
marketing ploy by Netscape to give JavaScript the 
cachet of what was then the hot new web-programming language.
</textarea>

	<script>
		$(function() {
			$(".lined").linedtextarea({
			//selectedLine : 1
			});
		});
	</script>
	<script>
		$(document).ready(function() {

			console.log("ready!");
			$("textarea").val('${contents}');
			setInputColor('green');
		});
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
	</script>
	<script type="text/javascript"
		src="./resources/script/setInputColor.js"></script>
	<script type="text/javascript" src="./resources/script/saveFunction.js"></script>
</body>
</html>
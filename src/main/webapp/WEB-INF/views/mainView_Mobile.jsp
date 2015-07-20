<!DOCTYPE html>
<html lang="en">
<head>
<title>JQuery LinedTextArea Demo</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
<!--320-->
	<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
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
#headdiv{
	height: 30px
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
	<textarea id="mainTextArea" onkeypress="onTextChange()"  class="lined" rows="200" cols="60">
</textarea>

	<script>
		var intervalId;
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
			setEditorType('${type}');
		});
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
					contents : $('#mainTextArea').val(),
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
		}
		//onTextViewChange
		function onTextChange() {
			setInputColor('red');
			window.clearInterval(intervalId);
			intervalId = (setTime(3000));
		}
		
	</script>
	<script>
	//set Editor Type
	function setEditorType(value) {
		$('#typeSelector option').eq(value).prop('selected',true);
	}
	</script>
	<script type="text/javascript"
		src="./resources/script/setInputColor.js"></script>
	<script type="text/javascript" src="./resources/script/saveFunction.js"></script>
</body>
</html>
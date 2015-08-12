<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Ghi nháp</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
<!--320-->
	<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src="./resources/jquery-linedtextarea.js"></script>
<link href="./resources/jquery-linedtextarea.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="./resources/script/functions.js"></script>
<link rel="stylesheet" type="text/css" href="./resources/css/custom.css">
<style type="text/css">
	textarea {
		width: 100%;
		min-height: 100%;
		word-wrap: break-word;
		height: 300%;
		font-size: 100%;
		background: #FFFDEB;
	}
	#headdiv{
		height: 30px;
		padding: 10px 0px 25px !important;
		border-radius: 0px !important;	
	}
	.select_wrapper {
		background: #87CEFA url("./resources/img/arrow.png") no-repeat top 10px right 12px;
		line-height: 30px;
		border-radius: 3px;
		cursor: pointer;
		position: relative;
		width: 150px !important;
		float: right;
		color: #fff;
		font-weight: bold;
		margin-right: 7px;		
		font-size: 15px;
	}	
	.select_wrapper:hover {
		background: #8DB6CD url("./resources/img/arrow.png") no-repeat top 10px right 12px; 
	}	
	.select_wrapper span {
		display: block;
		margin: 0 30px 0 15px;
	}	
	.select_wrapper .select_inner {
		background: #fff;
		border-radius: 5px;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
		color: #687278;
		display: none;
		position: absolute;
		left: 0;
		top: 0%;
		width: 100%;
		z-index: 3;
		padding: 0px;
	}	
	.select_wrapper .select_inner li {
		border-bottom: 1px solid #eee;
		padding: 0 15px;
		list-style: none;
	}	
	.select_wrapper .select_inner li:hover { background: #eee; }	
	.select_wrapper .select_inner li:last-child {
		border: none;
		border-radius: 0 0 5px 5px;
	}
	.select_wrapper .select_inner li:first-child { border-radius: 5px 5px 0 0; }
</style>
</head>
<body onresize="resizetoFix()">
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img alt="" src="">
		<img id="imglock" onclick="lockClick()" alt="lock"
			src="./resources/img/unlock.png" width="20px" height="20px" /> 
		<img id="imgUnlock" onclick="unLockClick()" alt="unlock"
		    src="./resources/img/lock.png" width="20px" height="20px" />
		<select id="typeSelector">
			<option value="0">Text-default</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<textarea id="mainTextArea" class="lined" rows="200" cols="60"
		onkeyup="onTextChange()" oncut="onTextChange()" onpaste="onTextChange()">
	</textarea>			
	<script>
		var intervalId;
		$(function() {
			$(".lined").linedtextarea({
			});
		});
	</script>	
	<script>
		$(document).ready(function() {
			$("#mainTextArea").val('${contents}');
			setInputColor('green');
			setEditorType('${type}');
			var isLock = '${isLock}';
			if (isLock === 'true') {
				$('#imgUnlock').css("visibility", "visible");
				$('#mainTextArea').prop("readonly", true);
				$('#typeSelector').prop("disabled", true);
			} else {
				$('#imglock').css("visibility", "visible");
			}
			
			$('.linedwrap').css("width","100%");
			$('linedtextarea').css("width","100%");
		});
		//set Time for Auto send function
		function setTime(time) {
			return window.setInterval($.sendContentToServer, time);
		}
		$.sendContentToServer = function sendContentToServer() {
			var type = document.getElementById('typeSelector').value;
			requestUpdateContent($('#mainTextArea').val(), '${noteid}', type);
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
		function lockClick() {
			requestLock('${noteid}');
		}
		function unLockClick() {
			requestUnlock('${noteid}');
		}
		//onresize the browser window
		function resizetoFix() {
			var codelines = 75/$(window).width();
			var maintext = (1 - codelines)*100;
			var percent = maintext.toString() + "%";
			$('.linedwrap').css("width","100%");
			$('linedtextarea').css("width","100%");
			$("textarea#mainTextArea").css("width",percent);
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
	<script type="text/javascript" 
		src="./resources/script/saveFunction.js">
	</script>	
	<script>
		$(document).ready(function (){
		$('select').wrap('<div class="select_wrapper"></div>')
		$('select').parent().prepend('<span>'+ $(this).find(':selected').text() +'</span>');
		$('select').parent().children('span').width($('select').width());	
		$('select').css('display', 'none');					
		$('select').parent().append('<ul class="select_inner"></ul>');
		$('select').children().each(function(){
			var opttext = $(this).text();
			var optval = $(this).val();
			$('select').parent()
					   .children('.select_inner')
					   .append('<li id="' + optval + '">' + opttext + '</li>');
		});

		$('select').parent().find('li').on('click', function (){
			var cur = $(this).attr('id');
			$('select').parent().children('span').text($(this).text());
			$('select').children().removeAttr('selected');
			$('select').children('[value="'+cur+'"]').attr('selected','selected');
			console.log($('select').children('[value="'+cur+'"]').text());
			//Change the type
			typeChange();
			});
		$('select').parent().on('click', function (){
			$(this).find('ul').slideToggle('fast');
			});
		});
	</script>			 	
</body>
</html>
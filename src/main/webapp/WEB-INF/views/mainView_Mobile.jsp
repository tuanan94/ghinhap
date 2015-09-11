<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Ghinhap.com</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
<!--320-->
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
	
	 
<script src="<c:url value="/resources/jquery-linedtextarea.js"/>" ></script>
<link href="<c:url value="/resources/jquery-linedtextarea.css"/>" 
	type="text/css" rel="stylesheet" />
<script type="text/javascript"
	src="<c:url value="/resources/script/functions.js"/>"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/custom.css"/>">
<style type="text/css">
#mainTextArea {
	width: 100%;
	min-height: 100%;
	word-wrap: break-word;
	height: 300%;
	font-size: 100%;
}

#headdiv {
	height: 30px
}
</style>
</head>
<body onresize="resizetoFix()">
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img alt="" src=""> <img id="imglock" onclick="lockClick()"
			alt="lock" src="<c:url value="/resources/img/unlock.png"/>" width="20px"
			height="20px"
			<c:choose>
			<c:when test="${isLock == 'true'}"> style="visibility: hidden;"</c:when>
			<c:when test="${isLock == 'false'}"> style="visibility: visible;"</c:when> 
			</c:choose>
			/> 
		<img id="imgUnlock" onclick="unLockClick()"
			alt="unlock" src="<c:url value="/resources/img/lock.png"/>" width="20px"
			height="20px" 
			<c:choose>
			<c:when test="${isLock == 'true'}"> style="visibility: visible;"</c:when>
			<c:when test="${isLock == 'false'}"> style="visibility: hidden;"</c:when> 
			</c:choose>
			/> 
		<select id="typeSelector" onchange="typeChange()">
			<option value="0">Text-default</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<textarea id="mainTextArea" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" onkeyup="onTextChange()"
		oncut="onTextChange()" onpaste="onTextChange()" class="lined"
		rows="200" cols="60">
</textarea>

	<script>
		var intervalId;
		$(function() {
			$(".lined").linedtextarea({});
		});
	</script>
	<script>
		$(document).ready(function() {
			var getUrlParameter = function getUrlParameter(sParam) {
			    var sPageURL = decodeURIComponent(document.location.search.substring(1)),
			        sURLVariables = sPageURL.split('&'),
			        sParameterName,
			        i;

			    for (i = 0; i < sURLVariables.length; i++) {
			        sParameterName = sURLVariables[i].split('=');

			        if (sParameterName[0] === sParam) {
			            return sParameterName[1] === undefined ? true : sParameterName[1];
			        }
			    }
			};
			if(/iPad|iPhone|iPod/.test(navigator.platform)){
				var param = getUrlParameter('onApp');
				if(param == null){
					document.location = 'ghinhap://?' + '${noteid}';
					var clickedAt = +new Date;
					  setTimeout( function()
					  {
						  if (+new Date - clickedAt < 500){
							  var mess;
							  var language = window.navigator.userLanguage || window.navigator.language;
								if(language == "vi-vn"){
									mess = "Tải ứng dụng Ghi Nháp trên iOS?";
								} else {
									mess = "Download Ghi Nháp application on iOS?";
								}
						      if(confirm(mess))
						      {
									if(language == "vi-vn"){
										document.location = 'https://itunes.apple.com/vn/app/ghi-nhap/id1033925258?mt=8';
									} else {
										document.location = 'https://itunes.apple.com/us/app/ghi-nhap/id1033925258?mt=8';
									}
						      }
						  }
					  }, 500);
				}
			}
			$("#mainTextArea").val('${contents}');
			setInputColor('green');
			setEditorType('${type}');
			var isLock = '${isLock}';
			if (isLock === 'true') {
				$('#imglock').remove();
				$('#mainTextArea').prop("readonly", true);
				$('#typeSelector').prop("disabled", true);
			} else {
				$('#imgUnlock').remove();
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
			$('#typeSelector option').eq(value).prop('selected', true);
		}
	</script>

</body>
</html>
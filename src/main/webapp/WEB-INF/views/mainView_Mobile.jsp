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
	
<script type="text/javascript"
	src="<c:url value="/resources/script/jquery.modal.js"/>"></script>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/jquery.modal.css"/>">
	
<link href="http://fonts.googleapis.com/css?family=Roboto:300,700" rel="stylesheet" type="text/css">

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

#appstore{
	font-family: Roboto; 
	font-size: 18px;
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
			height="20px" style="float: right;
			<c:choose>
			<c:when test="${isLock == 'true'}"> visibility: hidden;</c:when>
			<c:when test="${isLock == 'false'}"> visibility: visible;</c:when> 
			</c:choose>"
			/> 
		<img id="imgUnlock" onclick="unLockClick()"
			alt="unlock" src="<c:url value="/resources/img/lock.png"/>" width="20px"
			height="20px" style="float: right;
			<c:choose>
			<c:when test="${isLock == 'true'}"> visibility: visible;</c:when>
			<c:when test="${isLock == 'false'}"> visibility: hidden;</c:when> 
			</c:choose>"
			/> 
	</div>
	<textarea id="mainTextArea" autocomplete="off" autocorrect="off" autocapitalize="on" spellcheck="false" onkeyup="onTextChange()"
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
			
			$('.linedwrap').css("width","99.5%");
			$('linedtextarea').css("width","99.5%");
			$('.lines').css("display","none");
			$("textarea#mainTextArea").css("width","98%");
			$("textarea#mainTextArea").css("font-size","20px");
		});
		//set Time for Auto send function
		function setTime(time) {
			return window.setInterval($.sendContentToServer, time);
		}
		$.sendContentToServer = function sendContentToServer() {
			var type = 0;
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
			/* var codelines = 75/$(window).width();
			var maintext = (1 - codelines)*100;
			var percent = maintext.toString() + "%"; */
			$('.linedwrap').css("width","99.5%");
			$('linedtextarea').css("width","99.5%");
			$('.lines').css("display","none");
			/* $("textarea#mainTextArea").css("width",percent); */
			
			$("textarea#mainTextArea").css("width","98%");
		}
	</script>
	<script>
		//set Editor Type
		function setEditorType(value) {
			$('#typeSelector option').eq(value).prop('selected', true);
		}
	</script>
	
	<div id="appstore" style="display:none; width: 78%">
		<p>Ghi Nháp đã có trên App Store:</p>
		<img style="width:100%; max-width: 100%; float: center;" onclick="appBannerClick()" src="<c:url value="/resources/img/App-Banner.png"/>"/>
    	<p style="text-align: center;"><a href="#" onclick="javascript:dontShowAgain();" rel="modal:close"><i style="font-size: 10px;">Đóng và không hiện thông báo này lần sau</i></a></p>
  	</div>
	
	<a id="modalRef" href="#appstore" rel="modal:open" style="display: none;">Open Modal</a>
	
	<script type="text/javascript">
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
	
	function getCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
	    }
	    return "";
	};
	
	 window.onload = function() {
		 	

			if(!(/iPad|iPhone|iPod/.test(navigator.platform))){
				return;
			}
			
			var param = getUrlParameter('onApp');
			if(param != null){
				return;
			}
			
			var isShow = getCookie("showModal");
			if(isShow == "yes"){
				return;
			}
			
			$("#modalRef").modal();
		};
		
		function appBannerClick(){
			var language = window.navigator.userLanguage || window.navigator.language;
			if(language == "vi-vn"){
				document.location = 'https://itunes.apple.com/vn/app/ghi-nhap/id1033925258?mt=8';
			} else {
				document.location = 'https://itunes.apple.com/us/app/ghi-nhap/id1033925258?mt=8';
			}
		}
		
		function dontShowAgain(){
			document.cookie = "showModal=yes;";			
		}
	</script>
	
</body>
</html>
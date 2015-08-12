<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Ghi nháp</title>

<link rel="stylesheet" type="text/css" href="http://ghinhap.com/resources/css/custom.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="http://ghinhap.com/resources/src/ace.js"></script>
<script type="text/javascript" src="http://ghinhap.com/resources/script/setInputColor.js"></script>
<script type="text/javascript" src="http://ghinhap.com/resources/script/functions.js"></script>
<script type="text/javascript" src="http://ghinhap.com/resources/src/ext-language_tools.js"></script>
<style type="text/css">	
	.select_wrapper {
		background: #87CEFA url("./resources/img/arrow.png") no-repeat top 15px right 12px;
		line-height: 36px;
		border-radius: 3px;
		cursor: pointer;
		position: relative;
		width: 20%;
		float: right;
		color: #fff;
		font-weight: bold;
	}	
	.select_wrapper:hover {
		background: #8DB6CD url("./resources/img/arrow.png") no-repeat top 15px right 12px; 
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
	#headdiv {
		position: relative;
		width: inherit;
		background: #B2DFEE;
		padding: 15px 45px 40px;
		border-radius: 10px;	
		margin-bottom: -10px;}
	.ace-tomorrow .ace_gutter {
		background: #E3FFD1 !important;
	}
	.ace_content {
		background: #FFFDEB !important;
	}
</style>
</head>
<body>
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img id="imglock" onclick="lockClick()" alt="lock"
			src="http://ghinhap.com/resources/img/unlock.png" width="20px" height="20px" /> <img
			id="imgUnlock" onclick="unLockClick()" alt="unlock"
			src="http://ghinhap.com/resources/img/lock.png" width="20px" height="20px" /> 
		<select id="typeSelector">
			<option value="0">Text-mặc định</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<pre id="editor"></pre>

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
	</script>
	<script type="text/javascript">
		$(document).ready(function (){
		$('select').wrap('<div class="select_wrapper"></div>')
		$('select').parent().prepend('<span id="selector_type">'+ $(this).find(':selected').text() +'</span>');
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
			document.getElementById('typeSelector').value = cur;
			console.log($('select').children('[value="'+cur+'"]').text());
			//When click a type
			typeChange();
			});
		$('select').parent().on('click', function (){
			$(this).find('ul').slideToggle('fast');	
			});
		});			
	</script>
</body>
</html>

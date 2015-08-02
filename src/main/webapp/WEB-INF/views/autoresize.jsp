
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Ghi nháp</title>
<link rel="stylesheet" type="text/css" href="./resources/css/custom.css">
<link rel="stylesheet" type="text/css"
	href="./resources/css/bootstrap.css">
<script type="text/javascript"
	src="./resources/script/jquery-2.1.4.min.js"></script>
<script src="./resources/src/ace.js"></script>
<script type="text/javascript" src="./resources/script/setInputColor.js"></script>
<script type="text/javascript" src="./resources/script/shortcut.js"></script>
<script type="text/javascript" src="./resources/script/functions.js"></script>
<script type="text/javascript"
	src="./resources/src/ext-language_tools.js"></script>
<script type="text/javascript" src="./resources/script/bootstrap.min.js"></script>

</head>
<body>
	<div id="headdiv">
		<div class="input-color">
			<div class="color-box" style="background-color: #FF850A;"></div>
		</div>
		<img id="imglock" onclick="lockClick()" alt="lock"
			src="./resources/img/unlock.png" width="20px" height="20px" /> <img
			id="imgUnlock" onclick="unLockClick()" alt="unlock"
			src="./resources/img/lock.png" width="20px" height="20px" />
		<!-- Short link -->
		<input id="shortLinkcheckBox" type="checkbox" value="check-box"
			disabled="disabled" onchange="shortLinkCheckBoxOnchange()" />Rút gọn
		link <select id="typeSelector" onchange="typeChange()">
			<option value="0">Text-default</option>
			<option value="1">HTML</option>
			<option value="2">Java</option>
			<option value="3">C#</option>
			<option value="4">Objective-C</option>
			<option value="5">Javascript</option>
		</select>
	</div>
	<!-- Editor -->
	<pre id="editor"></pre>

	<div id="buttonRedirectNow" hidden="true">
		<input type="button" value="Chuyển link" onclick="redirectLink()" />
	</div>

	<div id="loading">

		<img alt="Loading..." width="30px" height="30px"
			src="./resources/img/loading.gif" />
	</div>
	<!-- BootStrapDialog -->
	
	<div class="modal fade" id="makeShortLinkModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" data-backdrop='static'>
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">New message</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="recipient-name" class="control-label">Mật khẩu:</label>
							<input type="text" class="form-control" id="modalPassword" >
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">Người sở hữu: </label>
							<input type="text" class="form-control" id="modalOwner">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" onclick="requestSetPasswordAndMakeShortLink()">Send message</button>
				</div>
			</div>
		</div>
	</div>
	<!-- BootStrapDialog -->
	<script>
		function requestSetPasswordAndMakeShortLink(noteId){
				
			var modal = $('#makeShortLinkModal');
			var noteId = '${noteid}';
			var password = modal.find('.modal-body #modalPassword').val();
			var owner = modal.find('.modal-body #modalOwner').val();
			$.ajax({
				type : "POST",
				url : "ajax/setpasswordAndMakeShortLink",
				data : {
					noteid : noteId,
					password : password,
					owner : owner

				},
				success : function(data) {
					if (data !== "true") {
						alert(data);
					}
					location.reload();
				},
				error : function(data) {
					alert("Request lock fail. Please try again.")
				}
			});			

		}
	
		$('#makeShortLinkModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget) // Button that triggered the modal
			var recipient = button.data('whatever') // Extract info from data-* attributes
			// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
			// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
			var modal = $(this)
			modal.find('.modal-title').text('Điền thông tin để thực hiện rút gọn link')
			modal.find('.modal-body input').val(recipient)
		});

		$('#makeShortLinkModal').on('hidden.bs.modal', function(event){
			
		});
		
	</script>







	<!-- 
		<script async
			src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
		ghinhap
		<ins class="adsbygoogle" style="display: block"
			google_adtest = “on”
			data-ad-client="ca-pub-7705407164776151" data-ad-slot="4662904020"
			data-ad-format="auto"></ins>
		<script>
			(adsbygoogle = window.adsbygoogle || []).push({});
		</script> 
		 -->

	<!-- Short link -->
	<script>
		function shortLinkCheckBoxOnchange() {
			var isCheck = $('#shortLinkcheckBox').prop("checked");
			if (isCheck) {
				if ('${isLock}' === 'false') {
					$('#makeShortLinkModal').modal('show');				
					return; //for test purpose
					
					var retVal = prompt("Nhập mật khẩu để thực hiện rút gọn link");
					if (retVal == null || retVal == '') {
						$('#shortLinkcheckBox').prop('checked', false);
						return;
					}
					
				} else {
					alert('Bạn không thể tạo short link khi ghi chú còn đang khóa. Err: 01');
				}

			} else {
				$.ajax({
					type : "POST",
					url : "ajax/unsetShortLink",
					data : {
						noteid : '${noteid}'
					},
					success : function(data) {
						if (data !== "true") {
							alert(data);
						}
						location.reload();
					},
					error : function(data) {
						alert("Không thể yêu cầu khoá nháp này. Hãy thử lại sau vài phút.");
					}
				});
			}

		}

		function checkUrl(url) {
			var httpString = 'http://';
			var httpsString = 'https://';
			var subtring = url.substring(0, 7);

			if (subtring === httpString || subtring === httpsString) {
				//do nothing
			} else {
				url = httpString + url;
				return url;
			}

			return true;
		}

		function redirectLink() {
			if ('${isShortLink}' === 'false') {
				return;
			}

			var url = '${contents}';
			url = checkUrl(url);
			$("#loading").show();
			setTimeout(function() {

				window.location.href = url;
			}, 5000);
		}
	</script>
	<script>
		//set up for editor
		var isFirst = true;
		var editor = ace.edit("editor");
		var intervalId;
		editorInit(editor);
		//set up when document ready
		$(document).ready(
				function() {
					$("#loading").hide();
					setInitParam('${contents}', '${type}', '${isLock}',
							'${isShortLink}');
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


</body>
</html>

//var hostName = "http://localhost:8080/ghichu/";
var hostName= location.protocol + '//' + location.host + "/";
/**
 * Init when start
 */
function setInitParam(content, type, islock) {
	console.log("ready!" + hostName);
	editor.setValue(content, 1);
	setEditorType(type);
	setInputColor('green');
	var isLock = islock;
	if (isLock === 'true') {
		$('#imglock').remove();
		editor.setReadOnly(true);
		$('#typeSelector').prop("disabled", true);
	} else {
		$('#imgUnlock').remove();
	}

}

/**
 * Send new content to server after setting type for 5s
 * 
 */
function typeChange() {
	setInputColor('red');
	window.clearInterval(intervalId);
	intervalId = (setTime(3000));
	setEditorType(document.getElementById('typeSelector').value);
}

/**
 * Set type of editor base on type value
 * 
 */
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

/**
 * Request lock content
 * 
 */
function requestLock(noteid) {
	
	var temp = {
			state0: {
				title: 'Khóa Nháp',
				html:'<p>Nhập mật khẩu để khóa nháp này:</p>'+
				'<input type="password" class="pure-input-1" name="password" value=""  />' +
				'<br><br>' +	
				'<label class="radio"><input type="radio" name="lock_type" value="unsecure" class="radioinput" checked/> Chỉ khóa cho chỉnh sửa nháp</label>'+
						'<label class="pure-radio"><input type="radio" name="lock_type" value="secure" class="radioinput" /> Khóa cả cho xem và chỉnh sửa nháp</label>',
				buttons: { Hủy: false, Khóa: true },
				focus: 1,
				submit:function(e,v,m,f){ 
					if(!v)
						$.prompt.close();
					else {
						console.log(f);
						e.preventDefault();
					}
					return false;
				}
			}
	};
	$.prompt(temp,{
		classes: {
			box: '',
			fade: '',
			prompt: '',
			close: '',
			title: 'lead',
			message: 'pure-form',
			buttons: '',
			button: 'pure-button',
			defaultButton: 'pure-button-primary'
		}
	});
	
//	
//	var retVal = prompt("Nhập mật khẩu để khóa nháp này");
//	if (retVal == null || retVal == '') {
//		return;
//	}
//	$.ajax({
//		type : "POST",
//		url : hostName + "ajax/setpassword",
//		data : {
//			noteid : noteid,
//			password : retVal
//
//		},
//		success : function(data) {
//			if (data !== "true") {
//				alert(data);
//				return;
//			}
//			location.reload();
//		},
//		error : function(xhr, textStatus, error) {
//			alert("Request lock fail, please try again!")
//		}
//	});
}
/**
 * Request unlock content
 * 
 */
function requestUnlock(noteid) {
	var retVal = prompt("Nhập mật khẩu để mở khóa!");
	if (retVal !== null && retVal !== '') {
		$.ajax({
			type : "POST",
			url : hostName + "ajax/unsetpassword",
			data : {
				noteid : noteid,
				password : retVal

			},
			success : function(data) {
				if (data !== "true") {
					alert(data);
				}
				location.reload();
				$('#typeSelector').prop("disabled", false);
			},
			error : function(data) {
				alert("set fail")
			}
		});
	}
}

/**
 * Request update conten
 * 
 */
function requestUpdateContent(content, noteid, type) {
	console.log("send content to server");
	setInputColor('orange');

	$.ajax({
		type : "POST",
		url : hostName + "ajax/savecontent",
		data : {
			contents : content,
			noteid : noteid,
			type : type

		},
		success : function(data) {
			setInputColor('green');
		},
		error : function(data) {
			setInputColor('red');
		}
	});
}
/**
 * Set init for editor
 * 
 */
function editorInit(editor) {
	editor.setTheme("ace/theme/tomorrow");
	editor.session.setMode("ace/mode/html");
	editor.setOptions({
		maxLines : 4000,
		enableBasicAutocompletion : true,
		enableSnippets : true,
		enableLiveAutocompletion : true

	});
	editor.getSession().setUseWrapMode(true);
	editor.on('input', function() {
		if (isFirst) {
			isFirst = false;
			return;
		}
		setInputColor('red');
		window.clearInterval(intervalId);
		intervalId = (setTime(3000));
	});

}

/**
 * Set time for auto saving
 * 
 */
function setTime(time) {
	return window.setInterval($.sendContentToServer, time);
}

/**
 * 
 */
// set Input Color
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

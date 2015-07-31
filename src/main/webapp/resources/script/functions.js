/**
 * Init when start
 */
function setInitParam(content, type, islock, isShortLink) {
	console.log("ready!");
	editor.setValue(content, 1);
	setEditorType(type);
	setInputColor('green');
	var isLock = islock;
	if (isLock === 'true') {
		$('#imgUnlock').css("visibility", "visible");
		editor.setReadOnly(true);
		$('#typeSelector').prop("disabled", true);
	} else {
		$('#imglock').css("visibility", "visible");
		$('#shortLinkcheckBox').removeAttr("disabled");
	}
	alert(isShortLink);
	if (isShortLink!='true') {
		$('#shortLinkcheckBox').removeAttr("disabled");
	}else{
		$('#shortLinkcheckBox').prop('checked',true);
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
	var retVal = prompt("Enter your password");
	if (retVal == null || retVal == '') {
		return;
	}
	$.ajax({
		type : "POST",
		url : "ajax/setpassword",
		data : {
			noteid : noteid,
			password : retVal

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
/**
 * Request unlock content
 * 
 */
function requestUnlock(noteid) {
	var retVal = prompt("Enter your password");
	if (retVal !== '') {
		$.ajax({
			type : "POST",
			url : "ajax/unsetpassword",
			data : {
				noteid : noteid,
				password : retVal

			},
			success : function(data) {
				if (data !== "true") {
					alert(data);
				}
				location.reload();
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
		url : "ajax/savecontent",
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

}

/**
 * Set time for auto saving
 * 
 */
function setTime(time) {
	return window.setInterval($.sendContentToServer, time);
}

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
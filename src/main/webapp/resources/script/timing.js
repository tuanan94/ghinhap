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
	
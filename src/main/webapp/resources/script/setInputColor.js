/**
 * 
 */
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
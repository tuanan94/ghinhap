<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
	   #editor {
        position: absolute;
        width: 500px;
        height: 400px;
    }
	</style>
	
</head>
<body>
  <script src="./resources/src/mode-javascript.js" type="text/javascript" charset="utf-8"></script>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
  <div id="editor">some text</div>
    <script src="./resources/src/ace.js" type="text/javascript" charset="utf-8"></script>
    <script>
        var editor = ace.edit("editor");
    </script>
</body>
</html>

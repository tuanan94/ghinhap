<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>ACE Editor Inside iframe</title>
  <style type="text/css" media="screen">
    /*!important without this top: 0; bottom: 0 doesn't work */
    body, html {
        position: absolute;
        top: 0px; bottom: 0; left: 0; right: 0;
        margin:0; padding:0;
        overflow:hidden
    }
    
    #editor { 
        padding: 20px;
        position: absolute;
        width: 80%;
        height: 80%;
    }
  </style>
</head>
<body>

<iframe id="editor" src="kitchen-sink.html"></iframe>

</body>
</html>

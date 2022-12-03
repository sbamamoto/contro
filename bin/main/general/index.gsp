<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->
<html>
    <head>
        <meta name="layout" content="main" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rooms</title>
        <script>
            $( document ).ready(function() {
            $('.collapse').collapse()
            $("li").removeClass("active");
            $("#tablet").addClass("active");
            });

            function switchPartymode (device, state) {
                $.get('${createLink(action:"switchMode", controller:"switchPartymode")}', {state:state});
            }   
 

        </script>
    </head>
    <body>
        <div class="container">

            <div class="row">
                
                <h1>Alle Geräte schalten</h1> 
                <a href="${createLink(action:"switchAll", controller:"switchDevice")}?state=150"><button class="btn btn-lg btn-primary" onclick="switchPartymode('ON');"><h1>ON</h1></button></a>
                <a href="${createLink(action:"switchAll", controller:"switchDevice")}?state=0"><button class="btn btn-lg btn-primary"><h1>OFF</h1></button></a>
            </div>
        </div>

    </body>
</html>

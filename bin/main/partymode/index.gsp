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
                
                <h1>Partymode is: ${mode}</h1> 
                <a href="${createLink(action:"switchMode", controller:"Partymode")}?state=ON"><button class="btn btn-lg btn-primary" onclick="switchPartymode('ON');"><h1>ON</h1></button></a>
                <a href="${createLink(action:"switchMode", controller:"Partymode")}?state=OFF"><button class="btn btn-lg btn-primary"><h1>OFF</h1></button></a>
            </div>
        </div>

    </body>
</html>

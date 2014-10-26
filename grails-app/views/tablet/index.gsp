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

            function switchDevice (device, state) {
                $.get('${createLink(action:"switchDevice", controller:"switchDevice")}', {device:device, state:state});
            }   

        </script>
    </head>
    <body>
        <div class="container">

            <div class="row">
                <div class="panel-group" id="accordion">
                    <% def i=1%>
                    <g:findAll var="room" in="${rooms}" expr="${it.devices?.size() }">

                        <div class="panel panel-default">
                            <div id="header-${room.name.replace(' ','_')}" class="panel-heading" onclick="$('#${room.name.replace(' ','_')}').collapse('toggle');">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion${i+=1}" href="#${room.name.replace(' ','_')}">
                                        <h1>${room.name}</h1>
                                    </a>
                                </h4>
                            </div>
                            <div id="${room.name.replace(' ','_')}" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <g:each var="device" in='${room.devices.sort{it.description}}'>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-success btn-lg" style="width:100%;"onclick="switchDevice('${device.device}', '150')"><h1>${device.description}</h1></button>
                                            <button type="button" class="btn btn-danger btn-lg" style="width:100%;" onclick="switchDevice('${device.device}', '0')"><h1>${device.description}</h1></button>
                                        </div>
                                        <p><br/><br/></p>
                                            <g:if test="${device.canDimm}">
                                            <p></p>
                                            <g:each var="dimm" in="${(1..15)}">
                                                <button type="button" class="btn btn-danger btn-lg" onclick="switchDevice('${device.device}', '${dimm*10}')">
                                                    <h1>${dimm}</h1></button>
                                                </g:each>
                                            </g:if>
                                        <p><br/><br/></p>
                                        </g:each>
                                </div>
                            </div>
                        </div>
                    </g:findAll>
                </div>
            </div>
        </div>

    </body>
</html>

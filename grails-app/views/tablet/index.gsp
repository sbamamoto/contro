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

            function switchRoom (room, state) {
                $.get('${createLink(action:"switchRoom", controller:"switchDevice")}', {room:room, state:state});
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
                                        <h1>${room.name}<button style="float:right;display: inline;"class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '150')">All ON</button>
                                        <button style="float:right;display: inline;"class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '0')">All OFF</button></h1>
                                    </a>
                                </h4>
                            </div>
                            <div id="${room.name.replace(' ','_')}" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <table class="tables">
                                        <g:each var="device" in='${room.devices.sort{it.description}}'>
                                            <tr>
                                                <td style="padding-top:15px;padding-right:3px;"><button type="button" class="btn btn-lg ${device.state=='ON' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '150')"><h1>ON</h1></button></td>
                                                <td style="padding-top:15px;padding-right:15px;"><button type="button" class="btn btn-lg ${device.state=='OFF' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '0')"><h1>OFF</h1></button></td>
                                                <td style="padding-top:25px;"><label style="font-size:40px;">${device.description}</label></td>
                                            </tr>
                                            <g:if test="${device.canDimm}">
                                                <tr> 
                                                    <td colspan="3">
                                                        <g:each var="dimm" in="${(1..15)}">
                                                            <button type="button" class="btn btn-danger btn-lg" onclick="switchDevice('${device.device}', '${dimm*10}')">
                                                                <h1>${dimm}</h1></button>
                                                        </g:each>
                                                    </td>
                                                </tr>
                                            </g:if>
                                        </g:each>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </g:findAll>
                </div>
            </div>
        </div>

    </body>
</html>

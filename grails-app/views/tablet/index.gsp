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

            function switchDevice (device, id, state) {
                $.get('${createLink(action:"switchDevice", controller:"switchDevice")}', {device:device, id:id, state:state});
                            
                if (state > 0) {
                    
                    activate = "-OFF-"+id;
                    deactivate ="-ON-"+id
                }
                else {
                    activate="-ON-"+id;
                    deactivate="-OFF-"+id;
                }
                //document.getElementById(device+activate).className = "btn-primary";
                
                $("#"+device+activate).switchClass("btn-default", "btn-primary", 1000)
                $("#"+device+deactivate).switchClass("btn-primary", "btn-default", 1000)
                
                //$("#"+device+activate).removeClass("btn-default");                
                
                //$("#"+device+deactivate).removeClass("btn-primary");                
                //$("#"+device+deactivate).addClass("btn-default");
                //$("#"+device+activate).addClass("btn-primary");
                
            }   

            function switchRoom (room, state) {
                $.get('${createLink(action:"switchRoom", controller:"switchDevice")}', {room:room, state:state});
            }   

        </script>
    </head>
    <body>
        <div class="container-fluid">

            <div class="row">

                <div class="accordion" id="accordion">
                    <% def i=1%>
                    <g:findAll var="room" in="${rooms}" expr="${it.devices?.size() }">

                        <div class="card">
                            <div id="header-${room.name.replace(' ','_')}" class="card-headers" onclick="$('#${room.name.replace(' ','_')}').collapse('toggle');">
                                <h4>
                                    <a data-toggle="collapse" data-parent="#accordion${i+=1}" href="#${room.name.replace(' ','_')}">
                                        <h1>${room.name}<button style="float:right;display: inline;" class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '150')">All ON</button>
                                        <button style="float:right;display: inline;" class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '0')">All OFF</button></h1>
                                    </a>
                                </h4>
                            </div>
                            <div id="${room.name.replace(' ','_')}" class="collapse collapse-show">
                                <div class="card-body">
                                    <table class="tables">
                                        <g:each var="device" in='${room.devices.sort{it.description}}'>
                                            <tr>
                                                <td style="padding-top:15px;padding-right:3px;"><button id="${device.device}-ON-${device.id}" type="button" class="btn btn-lg ${device.state=='ON' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '${device.id}', '150')"><h1>ON</h1></button></td>
                                                <td style="padding-top:15px;padding-right:15px;"><button id="${device.device}-OFF-${device.id}" type="button" class="btn btn-lg ${device.state=='OFF' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '${device.id}', '0')"><h1>OFF</h1></button></td>
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

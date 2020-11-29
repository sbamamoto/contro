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
                $("#slidertest").bootstrapSlider();
            });

            function switchDevice (address, channel, ability, value, url) {                
                $.get('${createLink(action:"switchDevice", controller:"switchDevice")}', {address:address, channel:channel, ability:ability, value:value, url:url});
                            
                if (value > 0) {
                    
                    activate = "-OFF-"+ability;
                    deactivate ="-ON-"+ability
                }
                else {
                    activate="-ON-"+ability;
                    deactivate="-OFF-"+ability;
                }
                console.log('Activating: [' +"#"+address.replace ('.', '-') + activate + ']');
                console.log('Dectivating: [' +"#"+address.replace ('.', '-') +deactivate + ']');
                $("#"+address.replace ('.', '-')+activate).switchClass("btn-default", "btn-primary", 1000);
                $("#"+address.replace ('.', '-')+deactivate).switchClass("btn-primary", "btn-default", 1000);
            }   

            function switchRoom (room, state) {
                $.get('${createLink(action:"switchRoom", controller:"switchDevice")}', {room:room, state:state});
            }   

        </script>
    </head>
    <body>
        <div class="container-fluid">

     
            <div class="row justify-content-md-center">
            <div class="col-md-12">
                <div class="accordion" id="accordion">
                    <% def i=1%>
                    <g:findAll var="room" in="${rooms}" expr="${it.devices?.size() }">

                        <div class="card">
                            <div id="header-${room.name.replace(' ','_')}" class="card-headers" onclick="$('#${room.name.replace(' ','_')}').collapse('toggle');">
                                <h4>
                                    <a style="text-decoration: none;" data-toggle="collapse" data-parent="#accordion${i+=1}" href="#${room.name.replace(' ','_')}">
                                        <h1>${room.name}<button style="float:right;display: inline;" class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '150')">All ON</button>
                                        <button style="float:right;display: inline;" class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '0')">All OFF</button></h1>
                                    </a>
                                </h4>
                            </div>
                            <div id="${room.name.replace(' ','_')}" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <table class="tables">
                                        <g:each var="device" in='${room.devices.sort{it.description}}'>
                                            <g:each var="ability" in='${device.abilities}'>
                                                <tr>
                                                    <td style="padding-top:15px;padding-right:3px;"><button id="${device.device.replaceAll('\\.','-')}-ON-${ability.id}" type="button" class="btn btn-lg ${device.state=='ON' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '${device.channel}', '${ability.id}', '1.0', '${device.controller.url}')"><h1>ON</h1></button></td>
                                                    <td style="padding-top:15px;padding-right:15px;"><button id="${device.device.replaceAll('\\.','-')}-OFF-${ability.id}" type="button" class="btn btn-lg ${device.state=='OFF' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '${device.channel}','${ability.id}', '0.0', '${device.controller.url}')"><h1>OFF</h1></button></td>
                                                    <td style="padding-top:25px;"><label style="font-size:40px;">${device.description}</label></td>
                                                </tr>
                                                <g:if test="${device.canDimm}">
                                                    <tr> 
                                                        <td colspan="3">
                                                            <div class="range range-success">
                                                                <input
                                                                    type="text"
                                                                    id="${device.device.replaceAll('\\.','-')}-SLIDE-${ability.id}"
                                                                    data-provide="slider"
                                                                    data-slider-min="${device.minDimm}"
                                                                    data-slider-max="${device.maxDimm}"
                                                                    data-slider-step="0.5"
                                                                    data-slider-value="20"
                                                                    data-slider-precision="1"
                                                                >                                                                
                                                                <button style="margin-left:25px" type="button" class="btn btn-info" onClick="switchDevice('${device.device}', '${device.channel}','${ability.id}', $('#${device.device.replaceAll('\\.','-')}-SLIDE-${ability.id}').bootstrapSlider('getValue'), '${device.controller.url}')">SET</button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </g:if>
                                            </g:each>
                                        </g:each>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </g:findAll>
                </div>      
                </div>     
            </div>
        </div>

    </body>
</html>

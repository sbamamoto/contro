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
            <div class="col-12 col-md-12 col-lg-12 col-xl-8">
                <div class="accordion" id="accordion">
                    <% def i=1%>
                    <g:findAll var="room" in="${rooms}" expr="${it.devices?.size() }">
                        <div class="card">
                            <div id="header-${room.name.replace(' ','_')}" class="card-headers" onclick="$('#${room.name.replace(' ','_')}').collapse('toggle');">
                                <a style="text-decoration: none;" data-toggle="collapse" data-parent="#accordion${i+=1}" href="#${room.name.replace(' ','_')}">
                                    <span class="cntr-accordion-title">${room.name}</span><button style="float:right;display: inline;" class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '150')">All ON</button>
                                    <button style="float:right;display: inline;" class="btn btn-success btn-lg" onclick="switchRoom('${room.id}', '0')">All OFF</button>
                                </a>
                            </div>
                            <div id="${room.name.replace(' ','_')}" class="collapse" data-parent="#accordion">
                                <div class="card-body">
                                    <table class="tables">  
                                        <g:each var="device" in='${room.devices.sort{it.description}}'>
                                            <g:each var="ability" in='${device.abilities}'>
                                                <tr>
                                                    <td style="padding-top:15px;padding-right:3px;"><button id="${device.device.replaceAll('\\.','-')}-ON-${ability.id}" type="button" class="btn btn-lg ${device.state=='ON' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '${device.channel}', '${ability.id}', '1.0', '${device.controller.url}')"><h1>ON</h1></button></td>
                                                    <td style="padding-top:15px;padding-right:15px;"><button id="${device.device.replaceAll('\\.','-')}-OFF-${ability.id}" type="button" class="btn btn-lg ${device.state=='OFF' ? 'btn-default' : 'btn-primary'}" onclick="switchDevice('${device.device}', '${device.channel}','${ability.id}', '0.0', '${device.controller.url}')"><h1>OFF</h1></button></td>
                                                    <td style="padding-top:25px;" width="70%"><label class='cntr-accordion-text'>${device.description}</label></td>                                                    
                                                    <td style="padding-top:25px;">                                                        
                                                        <g:if test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value}">
                                                            <% def volts = device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value %>
                                                            <g:if test="${device.values.stream().filter{it.key == 'LOW_BAT'}.findFirst().value?.value.toBoolean()}">
                                                                <span class="mdi mdi-battery-alert iconic-button">${volts}V</span> 
                                                            </g:if>
                                                            <g:elseif test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value.toDouble() >= 2.8}">
                                                                <span class="mdi mdi-battery iconic-button"> <label class="d-none d-xl-table-cell">${volts}V</span>
                                                            </g:elseif> 
                                                            <g:elseif test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value.toDouble() >= 2.7}">
                                                                <span class="mdi mdi-battery-80 iconic-button"><label class="d-none d-xl-table-cell">${volts}V</span>
                                                            </g:elseif> 
                                                            <g:elseif test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value.toDouble() >= 2.6}">
                                                                <span class="mdi mdi-battery-50 iconic-button"><label class="d-none d-xl-table-cell">${volts}V</span>
                                                            </g:elseif> 
                                                            <g:elseif test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value.toDouble() >= 2.5}">
                                                                <span class="mdi mdi-battery-20 iconic-button"><label class="d-none d-xl-table-cell">${volts}V</span>
                                                            </g:elseif> 
                                                            <g:elseif test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value.toDouble() >= 2.4}">
                                                                <span class="mdi mdi-battery-10 iconic-button"><label class="d-none d-xl-table-cell">${volts}V</span>
                                                            </g:elseif> 
                                                            <g:else test="${device.values.stream().filter{it.key == 'OPERATING_VOLTAGE'}.findFirst().value?.value.toDouble() >= 2.4}">
                                                                <span class="mdi mdi-battery-unknown iconic-button"></span>
                                                            </g:else>                                                            
                                                        </g:if>                                                        
                                                    </td>
                                                    <td style="padding-top:25px;">                                                    
                                                        <g:if test="${device.values.stream().filter{it.key == 'RSSI_DEVICE'}.findFirst().value}">
                                                            <% def rssi = device.values.stream().filter{it.key == 'RSSI_DEVICE'}.findFirst().value?.value%>
                                                            <g:if test="${rssi.toInteger() <= -70}">
                                                                <span class="mdi mdi-signal-cellular-1 iconic-button"><label class="d-none d-xl-table-cell">${rssi}dBm</label></span>
                                                            </g:if>
                                                            <g:elseif test="${rssi.toInteger() <= -60}">
                                                                <span class="mdi mdi-signal-cellular-2 iconic-button"><label class="d-none d-xl-table-cell">${rssi}dBm</label></span>
                                                            </g:elseif>
                                                            <g:else>
                                                                <span class="mdi mdi-signal-cellular-3 iconic-button"><label class="d-none d-xl-table-cell">${rssi}dBm</label></span>
                                                            </g:else>                                                         
                                                            
                                                        </g:if>                                                  
                                                    </td>                                                    
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

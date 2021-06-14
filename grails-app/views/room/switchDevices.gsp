<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <script>

            function switchDevice (switchBox, address, channel, ability, url) {    
                let value;
                if (switchBox.checked) {
                    value="1.0";
                }
                else {
                    value="0.0";
                }            
                
                $.get('${createLink(action:"switchDevice", controller:"switchDevice")}', {address:address, channel:channel, ability:ability, value:value, url:url});
                return true;
            }   
        </script>
    </head>
    <body>  
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-10">
                <g:form action="#">
                <g:findAll var="device" in='${room.devices.sort{it.description}}' expr='${it.abilities?.size() >0}'>
                    <div class="row justify-content-md-left" style="margin-left:10px;margin-top:10px;">
                        <div class="col-12 col-lg-12 col-xl-10" >        
                            <div class="cntr-slider">                
                                <input type="checkbox" class="cntr-slider-checkbox" id="SWX-${device.id}" ${device.state == 'ON' ? "checked":""} onClick="switchDevice(this, '${device.device}', '${device.channel}', '${device.abilities.getAt(0).id}', '${device.controller.url}')"/>
                                <label for="SWX-${device.id}" class="toggle">
                                    <div class="slider"></div>
                                </label>
                            </div>
                            <div class="cntr-switch-text">
                                ${device.description}
                                <g:if test="${device.state == "ERROR"}">
                                    <button type="button" class="btn btn-danger">Gerätefehler</button>
                                </g:if>
                            </div>
                        </div>
                    </div>
                </g:findAll>
                </g:form>
            </div>
        </div>
    </body>
</html>

<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'styles.css')}" />

        <script src="${resource(dir:'js',file:'toolcool-range-slider.min.js')}"></script>
        <script src="${resource(dir:'js',file:'plugins/tcrs-generated-labels.min.js')}"></script>
        <script src="${resource(dir:'js',file:'plugins/tcrs-storage.min.js')}"></script>

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
        <div class="modal fade" id="myModal">
            <div class="modal-dialog modal-dialog-centered modal modal-lg modal-xl">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Set Value</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <div class="modal-body" id="dimmer">    
                        <div class="wrapper">
                            <div class="row">
                                <div class="col-8">
                                    <div class="row value-display">
                                        <div id="value-display" class="col-6">20</div>
                                        <div class="col">°C</div>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <tc-range-slider
                                    id=value-slider
                                    min="5"
                                    max="25"
                                    value="15"
                                    slider-width="50px"
                                    slider-height="400px"
                                    pointer-width="90px"
                                    pointer-height="40px"
                                    pointer-radius="10px"
                                    type="vertical"
                                    height="90vh"
                                    storage-key="tc-range-slider-2"></tc-range-slider>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-success btn-responsive" data-dismiss="modal" onClick="readSliderValue();">Speichern</button>
                        <button type="button" class="btn btn-danger btn-responsive" data-dismiss="modal">Abbrechen</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-10">
                <g:form action="#">
                    <g:findAll var="device" in='${room.devices.sort{it.description}}' expr='${it.abilities?.size() >0}'>
                                <div class="row justify-content-md-left justify-content-md-left" style="margin-left:10px;margin-top:10px;">
                                    <div class="col-12 col-lg-12 col-xl-10" > 
                                        <g:if test="${device.type.guiController == 'SWITCH'}">
                                            <div class="cntr-slider">                
                                                <input type="checkbox" class="cntr-slider-checkbox" id="SWX-${device.id}" ${device.state == 'ON' ? "checked":""} onClick="switchDevice(this, '${device.device}', '${device.channel}', '${device.abilities.getAt(0).id}', '${device.controller.url}')"/>
                                                <label for="SWX-${device.id}" class="toggle">
                                                    <div class="slider"></div>
                                                </label>
                                            </div>
                                        </g:if>
                                        <div class="cntr-switch-text">
                                            <g:if test="${device.type.guiController == 'SLIDER'}"> <!-- Future use for Dimmer controls -->
                                                <span id="SV-${device.id}" class="badge rounded-pill bg-danger text-light value-btn" data-toggle="modal" data-target="#myModal" onClick="setSliderValue(${value.value});"> 
                                                    ${device.dimm}
                                                </span>
                                            </g:if> 
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
        <g:javascript>
            // Automatic round to 0.5 steps
            const $slider = document.getElementById( 'value-slider');
            const $temp_display = document.getElementById( 'value-display')
            $slider.addEventListener('change', (evt) => {
            const value = Math.round(evt.detail.value*2)/2;
            $temp_display.textContent = value.toFixed(1); //toString();
            });
            
            function setSliderValue(value) {
                $slider.value=value.toFixed(1);
            }
            
            function readSliderValue() {
                const $switch = document.getElementById('setValue');
                $switch.textContent = $slider.value;
                alert($switch.textContent);
            }
        </g:javascript>
    </body>
</html>

<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <script src="${resource(dir:'js',file:'pureknob.js')}"></script>
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
			/*
			 * Demo code for knob element.
			 */
			function demoKnob() {
				// Create knob element, 300 x 300 px in size.
				const knob = pureknob.createKnob(800, 800);

				// Set properties.
				knob.setProperty('angleStart', -0.75 * Math.PI);
				knob.setProperty('angleEnd', 0.75 * Math.PI);
				knob.setProperty('colorFG', '#88ff88');
				knob.setProperty('trackWidth', 0.4);
				knob.setProperty('valMin', 0);
				knob.setProperty('valMax', 100);

				// Set initial value.
				knob.setValue(50);

				/*
				 * Event listener.
				 *
				 * Parameter 'knob' is the knob object which was
				 * actuated. Allows you to associate data with
				 * it to discern which of your knobs was actuated.
				 *
				 * Parameter 'value' is the value which was set
				 * by the user.
				 */
				const listener = function(knob, value) {
					console.log(value);
				};

				knob.addListener(listener);

				// Create element node.
				const node = knob.node();

				// Add it to the DOM.
				const elem = document.getElementById('dimmer');
				elem.appendChild(node);
			}

        </script>
    </head>
    <body>  
        <div class="modal fade" id="myModal">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
            
                    <div class="modal-header">
                        <h4 class="modal-title">Modal Heading</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <div class="modal-body" id="dimmer">                   
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
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
                                <g:if test="${false}"> <!-- Future use for Dimmer controls -->
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                                        ${device.dimm}
                                    </button>
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
            $(document).ready(function(){
                demoKnob();
            });
    </g:javascript>
    </body>
</html>

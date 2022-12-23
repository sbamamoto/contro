
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
       
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

        <script>
            $(function () {
            $('[data-toggle="popover"]').popover()
            })

            function program(){
            var device = $('#device').val();
            $('#device-pop').popover('hide');
                var url = "${createLink(action:"programDevice")}/"+device;
            $.ajax({url:url});

            }
        </script>
    </head>
    <body>
        <div class="container">
            <div class="col-md-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Geräteliste</g:link></li>
                    </ul>
                </nav>
                <g:form action="saveDevice">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Basis Einstellungen</a>
                            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Zeiten</a>
                            <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Eigenschaften</a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <div class="form-group">
                                <label for="description">Beschreibung:</label>
                                <input type="text" class="form-control" name="device.description" id="description" placeHolder="Description" value="${deviceInstance?.description}"/>
                            </div>

                            <div class="form-group">
                                <label for="controller">Controller:</label>
                                <g:select from="${controllers}" class="form-control" id="controller" name="device.controller" value="${deviceInstance?.controller?.id}" optionKey="id" >
                                </g:select>
                            </div>
                            <div class="form-group">
                                <label for="type">Type:</label>
                                <g:select from="${deviceTypes}" class="form-control" id="type" name="device.type" value="${deviceInstance?.type?.id}" optionKey="id" optionValue="name">
                                </g:select>
                            </div>
                            <br/>
                            <div class="form-group">
                                <label for="description">Adresse:</label>
                                <div class="input-group">
                                    <span class="input-group-addon" id="program-device">
                                        <button type="button" class="btn btn-danger" data-toggle="popover" title="Programming Help" data-html="true" 
                                        data-content="Press button on device until button starts flashing.<br><br>When button flashes press program button.<br><br><button type='input' onclick='program();return false;' class='btn btn-primary' >Program Device</button>">PRG</button></span>
                                    <input type="text" class="form-control" name="device.device" id="device" placeHolder="Geräteadresse" value="${deviceInstance?.device}" aria-describedby="program-device"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="description">Kanal:</label>
                                <input type="text" class="form-control" name="device.channel" id="channel" placeHolder="Kanal" value="${deviceInstance?.channel}"/>
                            </div>

                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="device.canDimm" ${deviceInstance.canDimm ?"checked":""}/>
                                    dimmbar
                                </label>
                            </div>

                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="device.hasBatteries" ${deviceInstance.hasBatteries ?"checked":""}/>
                                    has batteries
                                </label>
                            </div>

                            <div class="form-group form-row">
                                <div class="col">
                                    <label for="description">Minimaler Dimmwert:</label>
                                    <input type="text" class="form-control" name="device.minDimm" id="minDimm" placeHolder="Minimum" value="${deviceInstance?.minDimm}"/>
                                </div>
                                <div class="col">
                                    <label for="description">Maximaler Dimmwert:</label>
                                    <input type="text" class="form-control" name="device.maxDimm" id="maxDimm" placeHolder="Maximum" value="${deviceInstance?.maxDimm}"/>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">            
                            <div style="height:500px;overflow-y: scroll;border: solid gainsboro thin; padding-left:5px;">
                                <g:each in="${allTimings}">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="${it.id}" name="device.timings" ${deviceTimings?.contains(it.id)?"checked":""}/>
                                            ${it}
                                        </label>
                                    </div>
                                </g:each>     
                            </div>
                        </div>
                        <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                            <div style="height:500px;overflow-y: scroll;border: solid gainsboro thin; padding-left:5px;">
                                <g:each in="${deviceTypeAbilities}">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="${it.id}" name="device.abilities" ${deviceAbilities?.contains(it.id)?"checked":""}/>
                                            ${it.description}
                                        </label>
                                    </div>
                                </g:each>                
                            </div>                        
                        </div>
                    </div>

                    <g:hiddenField name="device.id" value="${deviceInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>
        </div>
    </body>
</html>

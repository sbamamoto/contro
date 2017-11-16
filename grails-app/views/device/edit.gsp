
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
            <div class="col-md-4">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Geräteliste</g:link></li>
                        </ul>
                    </nav>
                <g:form action="saveDevice">
                    <div class="form-group">
                        <label for="description">Beschreibung:</label>
                        <input type="text" class="form-control" name="device.description" id="description" placeHolder="Description" value="${deviceInstance?.description}"/>
                    </div>

                    <div class=form-group">
                        <label for="controller">Controller:</label>
                        <g:select from="${controllers}" class="form-control" id="controller" name="device.controller" value="${deviceInstance?.controller?.id}" optionKey="id" >
                        </g:select>
                    </div>
                    <br/>
                    <div class="form-group">
                        <label for="description">Adresse:</label>
                        <div class="input-group">
                            <span class="input-group-addon" id="program-device">
                                <a href="#" role="button" data-toggle="popover" id="device-pop" title="Programming Help" data-html="true" 
                                data-content="Press button on device until button starts flashing.<br><br>When button flashes press program button.<br><br><button type='input' onclick='program();return false;' class='btn btn-primary' >Program Device</button>">PRG</a></button></span>
                            <input type="text" class="form-control" name="device.device" id="device" placeHolder="Geräteadresse" value="${deviceInstance?.device}" aria-describedby="program-device"/>
                        </div>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="device.canDimm" ${deviceInstance.canDimm ?"checked":""}/>
                            dimmbar
                        </label>
                    </div>
                    <br>
                    <div style="height:400px;overflow-y: scroll;border: solid gainsboro thin; padding-left:5px;">
                        <g:each in="${allTimings}">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="${it.id}" name="device.timings" ${deviceTimings?.contains(it.id)?"checked":""}/>
                                    ${it.description}
                                </label>
                            </div>
                        </g:each>                
                    </div><br>
                    <g:hiddenField name="device.id" value="${deviceInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>
        </div>
    </body>
</html>



<%@ page import="contro.RemoteControl" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'remoteControl.label', default: 'RemoteControl')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Raumliste</g:link></li>
                        </ul>
                    </nav>
                <g:form action="saveRemoteControl">
                    <div class="form-group">
                        <label for="remoteControlIdentity">RemoteControl Identity:</label>
                        <input type="text" class="form-control" name="identity" id="identity" placeHolder="RemoteControl Identity" value="${remoteControlInstance.identity}"/>
                    </div>
                    <div class="form-group">
                        <label for="switchMode">Schaltmodus:</label>
                        <input type="text" class="form-control" name="switchMode" id="switchMode" placeHolder="RemoteControl Identity" value="${remoteControlInstance.switchMode}"/>
                    </div>                    
                    <div class="form-group">
                        <label for="value">Schaltwert:</label>
                        <input type="text" class="form-control" name="value" id="value" placeHolder="RemoteControl Switch Value" value="${remoteControlInstance.value}"/>
                    </div>                    
                    <div class="form-group">
                        <label for="device">Device:</label>
                        <g:select from="${deviceList}" class="form-control" name="device" id="device" optionKey="id" value="${remoteControlInstance?.device?.id}" onChange="selected();">
                        </g:select>
                    </div>  
                    <div class="form-group">
                        <label for="ability">Ability:</label>
                        <g:select from="[]" optionKey="id" class="form-control" name="ability" id="ability">
                        </g:select>
                    </div>  
                    <g:hiddenField name="id" value="${remoteControlInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>

        </div>
        <script>
            function selected () {
                var url = '${createLink(controller:"device",action:"abilities")}';
                url = url + '/'+$('#device').find('option:selected').val();
                $.getJSON( url, function( data ) {
                    var items = [];
                    $.each( data, function( key, val ) {     
                        console.log(key+"-"+val);               
                        $('#ability').append(new Option(key, val, true, true));
                    });

                });
            }
        </script>
    </body>
</html>

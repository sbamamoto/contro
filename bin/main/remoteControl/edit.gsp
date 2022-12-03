

<%@ page import="contro.RemoteControl" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="dialog" content="dialog"/>
        <g:set var="entityName" value="${message(code: 'remoteControl.label', default: 'RemoteControl')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-8">
                <g:form name="remoteControlForm" action="saveRemoteControl" controller="remote">
                    <div class="form-group">
                        <label for="remoteControlIdentity">Schalter Id:</label>
                        <div class="input-group">
                            <a class="btn btn-success" name="read" id ="read" onclick="waitforcode();" role="button" href="#">PRG</a>
                            <input type="text" class="form-control" name="identity" id="identity" placeHolder="Switch Identity" value="${remoteControlInstance.identity}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="switchMode">Schaltmodus:</label>
                         <g:select from="${["ON", "OFF", "TOGGLE"]}" class="form-control" name="switchMode" id="switchMode" value="${remoteControlInstance?.switchMode}">
                            </g:select>
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
                        <g:select from="${remoteControlInstance?.device?.abilities}" optionKey="id" class="form-control" name="ability" id="ability" value="${remoteControlInstance?.ability}">
                        </g:select>
                    </div>  
                    <g:hiddenField name="id" value="${remoteControlInstance?.id}" />
                    <g:hiddenField name="remoteId" value="${remoteId}" />
                    <button class="btn btn-primary" type=submit>Save</button>
                </g:form>    
            </div>

        </div>
        <script>
            var timer;
            var retriesLeft;

            function selected () {
                var url = '${createLink(controller:"device",action:"abilities")}';
                url = url + '/'+$('#device').find('option:selected').val();
                $.getJSON( url, function( data ) {
                    var items = [];
                    $('#ability').empty();
                    $.each( data, function( key, val ) {     
                        console.log(key+"-"+val);               
                        $('#ability').append(new Option(key, val, true, true));
                    });

                });
            }
            function EditFormSubmit() {
                alert("XXX");
                $(".remoteControlForm").submit();
            }

            function timerStopped() {
                clearInterval(timer);
                $('#read').removeClass('btn-danger');
                $('#read').addClass('btn-success');
                $('#read').text('PRG');
            }

            function getLastPress() {
                
                if (retriesLeft <= 0) {
                    timerStopped();
                }
                else {
                    retriesLeft = retriesLeft -1;
                    $('#read').text(retriesLeft + ' Sek.');
                }
                let url = '${createLink(controller:"remote",action:"getLastButtonPressed")}';
                $.getJSON( url, function( data ) {
                    var items = [];                    
                    $.each( data, function( key, val ) {     
                        if (val != 'NOK') {
                            $('#identity').val(val);
                            timerStopped();
                        }
                    });
                });
            }

            function waitforcode() {
                let url = '${createLink(controller:"remote",action:"clearLastButton")}';
                $.getJSON( url, function( data ) {
                    retriesLeft = 10;
                    timer = setInterval (getLastPress, 1000);  
                    $('#identity').val("");
                    $('#read').text(retriesLeft + ' Sek.');
                    $('#read').removeClass('btn-success');
                    $('#read').addClass('btn-danger');
                });                
            }

        </script>
    </body>
</html>

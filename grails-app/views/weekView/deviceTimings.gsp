
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}"/>
        <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.print.css')}" media='print' />
        <link rel="stylesheet" href="${resource(dir:'css',file:'jquery-ui.css')}" />
        <script src="${resource(dir:'js',file:'moment.min.js')}"></script>
        <script src="${resource(dir:'js',file:'jquery-ui.min.js')}"></script>
        <script src="${resource(dir:'js',file:'fullcalendar.min.js')}"></script>


        <script>

            $(document).ready(function() {

            $(function() {
            $( "#dialog" ).dialog({
            resizable: false,
            autoOpen: false,
            height:280,
            width:400,
            modal: true,
            buttons: {
            "OK": function() {
            $( "form:first" ).submit();
            },
            Cancel: function() {
            $( this ).dialog( "close" );
            }
            }
            });

            $('#calendar').fullCalendar({
            header: {
            left: 'prev,next today',
            center: 'title',
            right: 'agendaWeek,agendaDay'
            },
    defaultDate: '<g:formatDate format="yyyy-MM-dd" date="${date}"/>',
            selectable: true,
            selectHelper: true,
            firstDay: 1,
            defaultView: 'agendaWeek',
            lang: 'de',
            eventClick: function(calEvent, jsEvent, view) {
            $("#deviceid").val(calEvent.devid);

            if (typeof calEvent.onid  !== "undefined") {
            $("#ondrop").val(calEvent.onid);
            $("#oldonid").val(calEvent.onid);
            }

            if (typeof calEvent.offid  !== "undefined") {
            $("#offdrop").val(calEvent.offid);
            $("#oldoffid").val(calEvent.offid);
            }
            $( "#dialog" ).dialog( "open" );

            },
            eventDrop: function(calEvent, delta , revertFunc, jsEvent, ui, view) {


            alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);

            // change the border color just for fun
            $(this).css('border-color', 'red');

            },
            editable: false,
            eventLimit: true, // allow "more" link when too many events
            events: [

            ${raw(events)}

            ],timeFormat: 'H(:mm)'
            });

            });

            });
        </script>
        <style>
            body {
            margin: 40px 10px;
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
            }

            #calendar {
            max-width: 900px;
            margin: 0 auto;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <legend>
            <h1>Schedule for: ${device.description}</h1>
            </legend>
            <div style="padding-top:20px;" id='calendar'></div>
            <div id="dialog" title="Basic dialog">
                <g:form id="changeschedule" action="changeschedule">
                    <table>
                        <tr>
                            <td>ON: </td>
                            <td><g:select id="ondrop" name="ontimings" from="${contro.Timing.list(sort:'description')}" optionKey="id" /></td>
                            <td style="padding-left: 15px;">Remove <input type="checkbox" name="removeOn"> </td>
                        </tr>
                        <tr>
                            <td>OFF: </td>
                            <td><g:select id="offdrop" name="offtimings" from="${contro.Timing.list(sort:'description')}" optionKey="id" /></td>
                            <td style="padding-left: 15px;">Remove <input type="checkbox" name="removeOff"></td>
                        </tr>
                    </table>
                    <input type="hidden" id="deviceid" name="deviceid"/>
                    <input type="hidden" id="oldonid" name="oldonid"/>
                    <input type="hidden" id="oldoffid" name="oldoffid"/>

                </g:form>
            </div>
        </div>
    </body>
</html>



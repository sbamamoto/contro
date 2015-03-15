

<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <div class="col-md-4">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Raumliste</g:link></li>
                        </ul>
                    </nav>
                <g:form action="saveRoom">
                    <div class="form-group">
                        <label for="roomName">Room:</label>
                        <input type="text" class="form-control" name="name" id="name" placeHolder="Room Name" value="${roomInstance.name}"/>
                    </div>
                    <g:each in="${allDevices}">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${it.id}" name="devices" ${associatedDevices?.contains(it.device)?"checked":""}/>
                                ${it.description}
                            </label>
                        </div>
                    </g:each>
                    <g:hiddenField name="id" value="${roomInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>

        </div>
    </body>
</html>

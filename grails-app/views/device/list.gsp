
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'device.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="canDimm" title="${message(code: 'device.canDimm.label', default: 'Can Dimm')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'device.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="state" title="${message(code: 'device.state.label', default: 'State')}" />
                        
                            <g:sortableColumn property="device" title="${message(code: 'device.device.label', default: 'Device')}" />
                        
                            <g:sortableColumn property="dimm" title="${message(code: 'device.dimm.label', default: 'Dimm')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deviceInstanceList}" status="i" var="deviceInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${deviceInstance.id}">${fieldValue(bean: deviceInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatBoolean boolean="${deviceInstance.canDimm}" /></td>
                        
                            <td>${fieldValue(bean: deviceInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: deviceInstance, field: "state")}</td>
                        
                            <td>${fieldValue(bean: deviceInstance, field: "device")}</td>
                        
                            <td>${fieldValue(bean: deviceInstance, field: "dimm")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${deviceInstanceTotal}" />
            </div>
        </div>
    </body>
</html>


<%@ page import="contro.Timing" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'timing.label', default: 'Timing')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
                <script>
            $( document ).ready(function() {
            $("li").removeClass("active");
            $("#timing").addClass("active");
            });
        </script>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'timing.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="power" title="${message(code: 'timing.power.label', default: 'Power')}" />
                        
                            <g:sortableColumn property="ramp" title="${message(code: 'timing.ramp.label', default: 'Ramp')}" />
                        
                            <g:sortableColumn property="timing" title="${message(code: 'timing.timing.label', default: 'Timing')}" />
                        
                            <g:sortableColumn property="dimmValue" title="${message(code: 'timing.dimmValue.label', default: 'Dimm Value')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'timing.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${timingInstanceList}" status="i" var="timingInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${timingInstance.id}">${fieldValue(bean: timingInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatBoolean boolean="${timingInstance.power}" /></td>
                        
                            <td><g:formatBoolean boolean="${timingInstance.ramp}" /></td>
                        
                            <td>${fieldValue(bean: timingInstance, field: "timing")}</td>
                        
                            <td>${fieldValue(bean: timingInstance, field: "dimmValue")}</td>
                        
                            <td>${fieldValue(bean: timingInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${timingInstanceTotal}" />
            </div>
        </div>
    </body>
</html>

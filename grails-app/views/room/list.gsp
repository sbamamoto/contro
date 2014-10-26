
<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
                <script>
            $( document ).ready(function() {
            $("li").removeClass("active");
            $("#rooms").addClass("active");
            });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'room.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'room.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${roomInstanceList}" status="i" var="roomInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${roomInstance.id}">${fieldValue(bean: roomInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: roomInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${roomInstanceTotal}" />
            </div>
        </div>
    </body>
</html>

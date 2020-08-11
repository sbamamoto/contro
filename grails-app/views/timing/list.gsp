
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

        <div class="container">
            <h1>Timingliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button>
            </h1>
            <g:if test="${flash.message}">
                <div class="${flash.textClass}">${flash.message}</div>
            </g:if>
            <div class="col-md-5">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Timing</th>
                            <th>Gerät wird</th>
                            <th>Uhrzeit</th>
                            <th>Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${timingInstanceList}" status="i" var="timingInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="edit" id="${timingInstance.id}">${fieldValue(bean: timingInstance, field: "description")}</g:link></td>

                                <td>${timingInstance.power ? "eingeschaltet" : "ausgeschaltet"}</td>

                                <td>${fieldValue(bean: timingInstance, field: "timing")}</td>

                                <td><a href="${createLink (action:'delete')}/${timingInstance.id}"  onClick="return confirm('Timing: [${timingInstance.description}] löschen ?');"><span class="fa fa-trash" aria-hidden="true"></span></a></td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="paginateButtons">
            <g:paginate total="${timingInstanceTotal}" />
        </div>
    </div>
</body>
</html>

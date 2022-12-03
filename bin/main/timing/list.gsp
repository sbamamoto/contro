
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
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-8">
                <h1>Timingliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button>
                </h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
            
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="cntr-table-text">Timing</th>
                            <th class="cntr-table-text d-none d-xl-table-cell">Gerät wird</th>
                            <th class="cntr-table-text d-none d-xl-table-cell">Geräteeigenschaft</th>
                            <th class="cntr-table-text d-none d-xl-table-cell">Wert</th>
                            <th class="cntr-table-text">Uhrzeit</th>
                            <th class="cntr-table-text">Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${timingInstanceList}" status="i" var="timingInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td class="cntr-table-text"><g:link action="edit" id="${timingInstance.id}">${timingInstance}</g:link></td>
                                <td class="cntr-table-text d-none d-xl-table-cell">${timingInstance.power ? "eingeschaltet" : "ausgeschaltet"}</td>
                                <td class="cntr-table-text d-none d-xl-table-cell">${timingInstance.ability}</td>
                                <td class="cntr-table-text d-none d-xl-table-cell">${timingInstance.dimmValue}</td>
                                <td class="cntr-table-text">${fieldValue(bean: timingInstance, field: "timing")}</td>

                                <td><a href="${createLink (action:'delete')}/${timingInstance.id}"  onClick="return confirm('Timing: [${timingInstance.description}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>

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

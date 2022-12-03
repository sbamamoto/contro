
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'Value.label', default: 'Value')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
                <div class="col-12 col-xl-8">
                                <nav>
                    <ul class="pager">
                        <li class="previous cntr-text"><g:link controller='device', action="list"><span aria-hidden="true">&larr;</span> Geräteliste</g:link></li>
                    </ul>
                </nav>
                    <h1>Werteliste (${device.description}) </h1>
                    <g:if test="${flash.message}">
                        <div class="${flash.textClass}">${flash.message}</div>
                    </g:if>
                    <table class="table table-striped" width="100%">
                        <thead>
                            <tr>
                                <th class="d-none d-lg-table-cell cntr-table-text">Kanal</th>
                                <th class="cntr-table-text">Schlüssel</th>
                                <th class="cntr-table-text">Wert</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${values}" status="i" var="value">
                                <tr>
                                    <td class="d-none d-lg-table-cell cntr-table-text">${value.channel}</td>
                                    <td class="cntr-table-text">${value.key}</td>
                                    <td class="cntr-table-text">${value.value}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>

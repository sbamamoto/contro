<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ability.label', default: 'Ability')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-8">
            <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="index"><span aria-hidden="true">&larr;</span> Systemvariablenliste</g:link></li>
                    </ul>
                </nav>
                <h1>Systemvariablen <a href="${createLink (action:'download')}/${key}"><span class="mdi mdi-download iconic-button" aria-hidden="true"></span></a></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="cntr-table-text">Key</th>
                            <th class="cntr-table-text">Value</th>
                            <th class="cntr-table-text">Typ</th>
                            <th class="cntr-table-text">Datum</th>
                            <th class="cntr-table-text">Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${globals}" status="i" var="global">
                        <tr>                        
                            <td class="cntr-table-text">${global.key}</td>
                            <td class="cntr-table-text">${global.value}</td>
                            <td class="cntr-table-text">${global.type}</td>
                            <td class="cntr-table-text">${global.date}</td>
                            <td class="cntr-table-text"><a href="${createLink (action:'delete')}/${global.id}"  onClick="return confirm('Systemvariable: [${global.key}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
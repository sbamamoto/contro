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
                <h1>Systemvariablen </h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="cntr-table-text">Name</th>
                            <th class="cntr-table-text">Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${globals}" status="i" var="global">
                        <tr>                        
                            <td class="cntr-table-text"><g:link action="list" id="${global}">${global}</g:link></td>
                            <td class="cntr-table-text"><a href="${createLink (action:'delete')}/${global}"  onClick="return confirm('Systemvariable: [${global}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
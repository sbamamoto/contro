
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deviceType.label', default: 'DeviceType')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
            <div class="col-md-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> DeviceTypescriptliste</g:link></li>
                    </ul>
                </nav>
                <g:form action="saveDeviceType" onSubmit="storeProcessingscript();">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-base-tab" data-toggle="tab" href="#nav-base" role="tab" aria-controls="nav-base" aria-selected="true">Basis Einstellungen</a>
                            <a class="nav-item nav-link" id="nav-abilities-tab" data-toggle="tab" href="#nav-abilities" role="tab" aria-controls="nav-abilities" aria-selected="false">Eigenschaften</a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-base" role="tabpanel" aria-labelledby="nav-base-tab">
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" name="deviceTypeForm.name" id="name" placeHolder="Name" value="${deviceTypeInstance?.name}"/>
                            </div>
                            <div class="form-group">
                                <label for="description">Beschreibung:</label>
                                <input type="text" class="form-control" name="deviceTypeForm.description" id="description" placeHolder="Beschreibung des Macros" value="${deviceTypeInstance?.description}"/>
                            </div>      
                            <div class="form-group">
                                <label for="type">Type:</label>
                                <g:select from="['VALUE', 'SLIDER', 'SWITCH']" class="form-control" id="type" name="deviceTypeForm.guiController" value="${deviceTypeInstance?.guiController}">
                                </g:select>
                            </div>           
                        </div>

                        <div class="tab-pane fade" id="nav-abilities" role="tabpanel" aria-labelledby="nav-abilities-tab">
                            <div style="height:500px;overflow-y: scroll;border: solid gainsboro thin; padding-left:5px;">
                                <g:each in="${abilityList}">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="${it.id}" name="deviceTypeForm.abilities" ${deviceTypeAbilities?.contains(it.id)?"checked":""}/>
                                            ${it.name}
                                        </label>
                                    </div>
                                </g:each>                
                            </div><br>
                        </div>                        
                    </div>   
                        <br>
                    <g:hiddenField name="deviceTypeForm.id" value="${deviceTypeInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>
            </div>
        </div>        
    </body>

</html>

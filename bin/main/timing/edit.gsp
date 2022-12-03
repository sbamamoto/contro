
<%@ page import="contro.Timing" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'timing.label', default: 'Timing')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="container">
            <div class="row">

                <div class="col-md-4">
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                    <nav>
                        <ul class="pager">
                            <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Timingliste</g:link></li>
                            </ul>
                        </nav>
                    <g:form action="update">
                        <div class="form-group">
                            <label for="timingDescription">Description:</label>
                            <input type="text" class="form-control" name="description" id="description" placeHolder="Description" value="${timingInstance.description}"/>
                        </div>
                        <div class="form-group">
                            <label for="time">Time:</label>
                            <input type="text" class="form-control" name="timing" id="timing" placeHolder="Time HH:MM" value="${timingInstance.timing}"/>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.power}" name="power" ${timingInstance.power?"checked":""}/>
                                Power
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="type">Ability</label>
                            <g:select from="${abilities}" class="form-control" id="ability" name="ability" value="${timingInstance?.ability?.id}" optionKey="id" optionValue="name">
                            </g:select>
                        </div>                        
                        <div class="form-group">
                            <label for="Intensity">Intensity:</label>
                            <input type="text" class="form-control" name="dimmValue" id="dimmValue" placeHolder="Intensity" value="${timingInstance.dimmValue}"/>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.ramp}" name="ramp" ${timingInstance.ramp?"checked":""}/>
                                Ramp
                            </label>
                        </div>
                        <br>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.monday}" name="monday" ${timingInstance.monday?"checked":""}/>
                                Montag
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.tuesday}" name="tuesday" ${timingInstance.tuesday?"checked":""}/>
                                Dienstag
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.wednesday}" name="wednesday" ${timingInstance.wednesday?"checked":""}/>
                                Mittwoch
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.thursday}" name="thursday" ${timingInstance.thursday?"checked":""}/>
                                Donnerstag
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.friday}" name="friday" ${timingInstance.friday?"checked":""}/>
                                Freitag
                            </label>
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.saturday}" name="saturday" ${timingInstance.saturday?"checked":""}/>
                                Samstag
                            </label>
                        </div>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="${timingInstance.sunday}" name="sunday" ${timingInstance.sunday?"checked":""}/>
                                Sonntag
                            </label>
                        </div>
                        <br>
                        <g:hiddenField name="id" value="${timingInstance?.id}" />
                        <button type="submit" class="btn btn-primary">Save</button>
                    </g:form>    
                </div>
                <div class="col-md-4" style="margin-top:100px;">
                <h4>Durch das Timing gesteuert:</h4>
                <ul class="list-group">
<g:each in="${devices}">
                        <li class="list-group-item">${it.description}</li>
                        
                        
                        </g:each>
                </ul>
                </div>
            </div>
        </div>
    </body>
</html>

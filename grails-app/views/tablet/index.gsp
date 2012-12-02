<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->
<html>
  <head>
    <gui:resources components="['accordion']"/>
    <meta name="layout" content="subframe" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sample title</title>
  </head>
  <body>
    <h1>Raumliste</h1>
    <gui:accordion bounce="true" slow="true" multiple="true">
      <g:findAll var="room" in="${rooms}" expr="${it.devices?.size() }">
          <gui:accordionElement title="${room.name}">
          <g:each var="device" in="${room.devices}">
            <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'0']}">
                [${device.description}-OFF]
            </g:link>
            &nbsp;&nbsp;
            <g:if test="${device.canDimm}">
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'10']}">
                  [DIMM-01]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'20']}">
                  [DIMM-02]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'30']}">
                  [DIMM-03]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'40']}">
                  [DIMM-04]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'50']}">
                  [DIMM-05]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'60']}">
                  [DIMM-06]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'70']}">
                  [DIMM-07]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'80']}">
                  [DIMM-08]&nbsp;            
            </g:link>

                  <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'90']}">
                  [DIMM-09]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'100']}">
                  [DIMM-10]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'110']}">
                  [DIMM-11]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'120']}">
                  [DIMM-12]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'130']}">
                  [DIMM-13]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'140']}">
                  [DIMM-14]&nbsp;            
            </g:link>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'150']}">
                  [DIMM-ON]&nbsp;            
            </g:link>
            </g:if>
            <g:else>
              <g:link controller="switchDevice" action="switchDevice" params="${['device':device.device,'state':'150']}">
                  [${device.description}-ON]
              </g:link>
            </g:else>
          </g:each>
        </gui:accordionElement>
    </g:findAll>
</gui:accordion>
  </body>
</html>

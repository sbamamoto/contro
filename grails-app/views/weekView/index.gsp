<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="${resource(dir:'css',file:'calendar.css')}" />
    <title>Sample title</title>

  </head>
  <body>
    <script>
  $(function() {
      $( ".deviceon" ).draggable({
        appendTo: "body",
        cursor: "move",
        helper: 'clone',
        revert: "invalid"
      });
      
      $( ".day" ).droppable({
        tolerance: "intersect",
        accept: ".deviceon",
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover",
        drop: function(event, ui) {
            $(this).append($(ui.draggable));
        }
      });
  });
    </script>
    <h1>Wochenübersicht</h1>

    <div id="0000" class="wrapper">
      <div id="droppable" class="monday day">
        <div class="deviceon" id="timingItem">ON Fenster 0:00</div>
      </div>
      <div id="droppable" class="tuesday day"></div>
      <div id="2" class="wednesday"></div>
      <div id="3" class="thursday"></div>
      <div id="4" class="friday"></div>
      <div id="5" class="saturday"></div>
      <div id="6" class="sunday"></div>
    </div>

    <table>
      <tr class="calendarTitle">
        <th class="timeTitle">Zeit</th>
        <th>Montag</th>
        <th>Dienstag</th>
        <th>Mittwoch</th>
        <th>Donnerstag</th>
        <th>Freitag</th>
        <th>Samstag</th>
        <th>Sonntag</th>
      </tr><g:each var="day" in='${0..6}'>
        <td id="timingItem"  class="device">
        <g:if test="${week[day]!=null}">
          <g:each in="${week[day][hour]}">
            <div id="timingItem" class="${it[1]}">
              <g:link class="menu" controller="device" action="show" id="${it[2]}"> ${it[0]}</g:link>
            </div>
          </g:each>
        </g:if>
        </td>
      </g:each>
      <g:each var="hour" in="${0..23}">
        <g:if test="${hour%2==0}">
          <tr class="even">
        </g:if>
        <g:else>
          <tr class="odd">
        </g:else>
        <th>${hour}-${hour+1}</th>
        <g:each var="day" in='${0..6}'>
          <td id="timingItem"  class="device">
          <g:if test="${week[day]!=null}">
            <g:each in="${week[day][hour]}">
              <div id="timingItem" class="${it[1]}">
                <g:link class="menu" controller="device" action="show" id="${it[2]}"> ${it[0]}</g:link>
              </div>
            </g:each>
          </g:if>
          </td>
        </g:each>
        </tr>
      </g:each> 

    </table>
  </body>
</html>

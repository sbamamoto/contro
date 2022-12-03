<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sample title</title>
  </head>
  <body>
    <table>
      <tr>
        <th>Time</th>
        <th>MO</th>
        <th>DI</th>
        <th>MI</th>
        <th>DO</th>
        <th>FR</th>
        <th>SA</th>
        <th>SO</th>
      </tr>
      <tr>
      <g:each in="${timeTable}" var="hours">
          <th>0:00</th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
          <th></th>
        </g:each>
      </tr>
    </table>
  </body>
</html>

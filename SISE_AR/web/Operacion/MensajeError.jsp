<%@ page contentType="text/html;charset=windows-1252"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>untitled</title>
  </head>
  <body>
  <%
  
    String strMsg = "";
    if (request.getAttribute("Msg")!=null){
      strMsg=request.getAttribute("Msg").toString();
    }
  %><script>
       alert('<%=strMsg%>';
  </script>
  </body>
</html>

<%@ page contentType="text/html;charset=windows-1252"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>untitled</title>
  </head>
  <body>
  <script>
  <% 
  
    String strPiso = "";

    if(request.getParameter("T")!=null){
        strPiso=request.getParameter("T").toString();
    }
    
    
    if (strPiso.equalsIgnoreCase("1")){ %>
        window.open('FraCentroComando.jsp?','Concierge','resizable=yes,menubar=0,status=0,toolbar=0,height=1024,width=1280,screenX=0,screenY=0,fullscreen=yes');    
    <%}%>
   
  </script>
  </body>
</html>

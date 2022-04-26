<%@ page contentType="text/html;charset=windows-1252"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>untitled</title>
  </head>
  <body>
  <script>
  <% 
    String strPiso="3";
    if(request.getParameter("T")!=null){
      strPiso=request.getParameter("T").toString();
    }
    if (strPiso.compareToIgnoreCase("3")==0){
  %>
    window.open('FraCentroComandoP3.jsp?','New','resizable=yes,menubar=0,status=0,toolbar=0,height=1024,width=1280,screenX=0,screenY=0,fullscreen=yes');    
  <%}
    if (strPiso.compareToIgnoreCase("4")==0){
  %>
		window.open('FraCentroComandoP4.jsp?','New','resizable=yes,menubar=0,status=0,toolbar=0,height=1024,width=1280,screenX=0,screenY=0,fullscreen=yes');    
  <%}
    if (strPiso.compareToIgnoreCase("1")==0){
  %>
    window.open('FraCentroComandoAll.jsp?','New','resizable=yes,menubar=0,status=0,toolbar=0,height=1024,width=1280,screenX=0,screenY=0,fullscreen=yes');    


    <%}if (strPiso.compareToIgnoreCase("6")==0){
  %>
    window.open('FraCentroComandoVentas.jsp?','New','resizable=yes,menubar=0,status=0,toolbar=0,height=1024,width=1280,screenX=0,screenY=0,fullscreen=yes');    
  <%}%>
  
  </script>
  </body>
</html>

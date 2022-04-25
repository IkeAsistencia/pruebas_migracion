<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>Cancela Experiencia</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody" onLoad="">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" />
        <script type="text/javascript" src='../../Utilerias/Util.js' ></script>
        <div class='VTable' style='position:absolute; z-index:25; left:10px; top:10px; right:10px;'>
            <p align="center"><font color="navy" face="Arial" size="2" ><b><i></i></b></font><br>
            </p>
        </div> 
        <%             
            String StrClCSExpPriceless = "0";
            String StrProceso = "0";            
            String StrNAdultos = "0";
            String StrError = "";
            String StrWList = "0";
            ResultSet rs = null;
                            
            if(request.getParameter("clCSExpPriceless") != null){
                StrClCSExpPriceless = request.getParameter("clCSExpPriceless").toString();                
            }
            
            if(request.getParameter("valProceso") != null){
                StrProceso = request.getParameter("valProceso").toString();                
            }
            
            if(request.getParameter("NAdultos") != null){
                StrNAdultos = request.getParameter("NAdultos").toString();                
            }
 
            rs = UtileriasBDF.rsSQLNP("st_CancelaCSExpPrice " + StrClCSExpPriceless + "," + StrProceso+ "," + StrNAdultos);

            if(rs.next()){
                 StrClCSExpPriceless = rs.getString("ClCSExpPricelessR");
                 StrError = rs.getString("Error");
                 StrWList = rs.getString("WList");                    
            }                  
            
            System.out.println("valores cancelacion: StrClCSExpPriceless " +  StrClCSExpPriceless + " Error: " + StrError +   " WL: " + StrWList);            
            rs.close();
            rs = null;  
            %>
            <script>
                  if(<%=StrWList%> == '1'){alert("EXPERIENCIA CON USUARIOS EN LISTA DE ESPERA !")}                
                  top.opener.location.href('<%=request.getContextPath()%>/Operacion/Concierge/CSExperienciasPriceless.jsp?');                
                  window.close();
            </script>
    </body>
</html>



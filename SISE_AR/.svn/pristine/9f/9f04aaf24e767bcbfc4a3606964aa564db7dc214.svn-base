<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.lang.String,java.sql.ResultSetMetaData,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC,java.util.Date" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}            
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}            
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;} 
            .STableReg{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
        </style>
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

<%  

    String StrclUsrApp="0";

    if (session.getAttribute("clUsrApp")!= null) {
        StrclUsrApp = session.getAttribute("clUsrApp").toString();
    }

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
            %>Fuera de Horario<%  return; 
    }

            String StrclPaginaWeb = "707";
    session.setAttribute("clPaginaWebP",StrclPaginaWeb);
    
    MyUtil.InicializaParametrosC(707,Integer.parseInt(StrclUsrApp));
    
    StringBuffer StrSql = new StringBuffer();
    
    StrSql.append("st_GNPrptRecuperacionTerc 1"); 
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    
    ResultSetMetaData info = rs.getMetaData();
    
    Date hoy = new Date();
        
    StringBuffer strSalida = new StringBuffer();        
    
    int i,j,k,l;
    String StrAtributo="";
    String StrRegion="";
    
    StrSql.append("<div style='position:absolute; z-index:20; left:10px; top:55px;'>");
    StrSql.append("<font class='STableTitRpt'> <center>Registro de la Operacion<br><br>Acumulado ");
    StrSql.append(hoy.getYear() + 1900).append("</center> </font><br>");
    
    hoy=null;
    
    StrSql.append("<table border='1' cellspacing='0' cellpadding='1'><tr class='STableTit'>");
    
    StrSql.append("<td colspan='3'>RECUPERACION DE TERCEROS</td> ");
    
    for (i=1; i<=14; i++){
        
        StrSql.append("<td>").append(info.getColumnName(i+4)).append("</td>");
    }
    
    StrSql.append("</tr><tr>");
        
    while (rs.next()){
        for (i=1; i<=6; i++){                     
            
            if(i==6){
                StrSql.append("<td rowspan='6' class='STableTit'>").append(rs.getString("regional").replace("2006   Num","")).append("</td>");                
            }else{
                StrSql.append("<td rowspan='6' class='STableReg'>").append(rs.getString("regional").replace("2006   Num","")).append("</td>");
            }

            for (j=1; j<=3; j++){
                
                StrAtributo=rs.getString("years");
                
                if(i==6){
                    
                    if (StrAtributo.equalsIgnoreCase("0")){
                        StrSql.append("<td rowspan='2' class='STableTit'>DIF</td>");
                    }else{
                        StrSql.append("<td rowspan='2' class='STableTit'>").append(rs.getString("years")).append("</td>");
                    }                    
                }else{                    
                    if (StrAtributo.equalsIgnoreCase("0")){
                        StrSql.append("<td rowspan='2' class='STableReg'>DIF</td>");
                    }else{
                        StrSql.append("<td rowspan='2' class='STableReg'>").append(rs.getString("years")).append("</td>");
                    }
                }
                
                for(k=1; k<=2; k++){         
                    
                    
                    if(i==6){
                        if(k==1){
                            StrSql.append("<td class='STableTit'>Num</td>");
                        }else{
                            StrSql.append("<td class='STableTit'>Monto</td>");
                        }
                    }else{
                        if(k==1){
                            StrSql.append("<td class='STableR1'>Num</td>");
                        }else{
                            StrSql.append("<td class='STableR2'>Monto</td>");
                        }
                    }
                    
                    for(l=1; l<=14; l++){
                                                
                        if(i==6){
                            StrSql.append("<td class='STableTit'>").append(rs.getString(l+4)).append("</td>");
                        }else{
                            if(k==1){
                                StrSql.append("<td class='STableR1'>").append(rs.getString(l+4)).append("</td>");
                            }else{
                                StrSql.append("<td class='STableR2'>").append(rs.getString(l+4)).append("</td>");
                            }
                        }
                    }
                    
                    if (!rs.isLast()){rs.next();}
                    StrSql.append("</tr><tr>");
                   
                }
                
            }
            
        }
        
    }
    
    StrSql.append("</table></div>");
    
    %>

    <%=StrSql.toString()%>
<%
   StrSql.delete(0,StrSql.length());   
%>
        <div style='position:absolute; z-index:20; left:10px; top:750px;'>            
            <IMG SRC="..\\SGrafica?type=st_GNPrptRecuperacionTerc 2&dsCampo=Regional&dsCampoCan=&Tipo=4&Pagina=707&Titulo=" BORDER=1/>            
        </div> 
        <div style='position:absolute; z-index:20; left:530px; top:750px;'>            
            <IMG SRC="..\\SGrafica?type=st_GNPrptRecuperacionTerc 3&dsCampo=years&dsCampoCan=&Tipo=5&Pagina=707&Titulo=" BORDER=1/>
        </div>     
<%                 
       rs.close();
       rs=null;
       StrSql=null;       
       StrclUsrApp=null;

%> 

</body>
</html>


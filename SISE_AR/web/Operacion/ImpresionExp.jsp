<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>IMPRESION EXPEDIENTE</title> 
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head> 
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>
<%  
    String StrPag="";
    StringBuffer StrSql=new StringBuffer();    
    String StrclUsrApp="0";
    String StrclExpediente="0";
    String StrclPaginaWeb="0";
    String StrclProveedor="0";   
    int iCont=0;
    
    
  
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %>Fuera de Horario<%
       return;  
     }    
    
    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     } 

    StrclPaginaWeb = "337";        
    MyUtil.InicializaParametrosC(337,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
    
    StrSql.append("sp_ImprimeExpediente ").append(StrclExpediente);
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());

    %><form id='Forma' name ='Forma'  action='ImpresionExp.jsp?' method='get'><%
    if (rs.next())
    {
        %><table class='TTable'>
        <tr><th colspan=4>DATOS GENERALES DEL EXPEDIENTE</th></tr><tr></tr><tr></tr>
        <%
	iCont = 2;
	   %><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td> 
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2; %>
	   </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
	   <% iCont = iCont + 2;  %>
	   </tr><tr><td colspan='4'>============================================================================================</td></tr>
           <%
                rs.close();
                
                StrSql.append("sp_ImprimeExpedienteSeg ").append(StrclExpediente);
                rs = UtileriasBDF.rsSQLNP( StrSql.toString());
                StrSql.delete(0,StrSql.length());
                %><table class='TTable'>
                <tr><th colspan=4>Bitácora del Expediente</th></tr><tr></tr><tr></tr>
                <%
                while (rs.next())
                {
                   iCont = 2;
                   %><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
                   <% iCont = iCont + 2; %>
                   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
                   <% iCont = iCont + 2; %>
                   </tr>
                   <tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
                   <% iCont = iCont + 2; %>
                   <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
                   </tr><tr></tr><tr><td colspan='4'>-----------------------------------------------------------------------------------------------------------------------------------------------------------</td></tr>
                   <%
                } 
                rs.close();
                StrSql.append("sp_ImprimeExpedienteSegProv ").append(StrclExpediente);
                rs = UtileriasBDF.rsSQLNP( StrSql.toString());
                StrSql.delete(0,StrSql.length());
                %><table class='TTable'>
                <tr><th colspan=4>Bitácora de Proveedores</th></tr><tr></tr><tr></tr>
                <% while (rs.next())
                {
                           iCont = 2; %>
                           <tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
                           <% iCont = iCont + 2; %>
                           <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
                           <% iCont = iCont + 2; %>
                           </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rs.getString(iCont-1)%></td>
                           <% iCont = iCont + 2; %>
                           <td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rs.getString(iCont-1)%></td>
                           <% iCont = iCont + 2; %>
                           </tr><tr><td width='150'><%=rs.getString(iCont)%>: </td><td class='R1Table' colspan='3'><%=rs.getString(iCont-1)%></td>
                           </tr><tr></tr><tr><td colspan='4'>-----------------------------------------------------------------------------------------------------------------------------------------------------------</td></tr>
                <%
                }
                
                
                StrSql.append("select coalesce(clsubservicio,'0') as  clsubservicio from Expediente where clExpediente= ").append(StrclExpediente);
                rs = UtileriasBDF.rsSQLNP( StrSql.toString());
                StrSql.delete(0,StrSql.length());
                if (rs.next())
                  {
                    String strInter= rs.getString("clsubservicio");
                    rs.close();
                    if (strInter.equalsIgnoreCase("284") || strInter.equalsIgnoreCase("254") || strInter.equalsIgnoreCase("285") || strInter.equalsIgnoreCase("282") || strInter.equalsIgnoreCase("283"))
                      {
                              StrSql.append("sp_ImprimeExpedienteInterven ").append(StrclExpediente);
                              ResultSet rsD = UtileriasBDF.rsSQLNP( StrSql.toString());
                              StrSql.delete(0,StrSql.length());
                                
                            %>
                              <table class='TTable'>
                              <tr><th colspan=4>INTERVENCIONES</th></tr><tr></tr><tr></tr>
                                <% while (rsD.next())
                                  {
                                  
                                            iCont = 2; %>
                                           <tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr><tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr><tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr><tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr><tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <tr>
                                           </tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsD.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr><tr><td width='150'><%=rsD.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsD.getString(iCont-1)%></td>
                                           </tr><tr></tr><tr><td colspan='4'>-----------------------------------------------------------------------------------------------------------------------------------------------------------</td></tr>
                                           
                                            
                                <%
                                  
                                  }
                                  
                                  StrSql.append("sp_ImprimeExpedienteLlamada ").append(StrclExpediente);
                                  ResultSet rsL = UtileriasBDF.rsSQLNP( StrSql.toString());
                                  StrSql.delete(0,StrSql.length()); 
                                %>
                                <table class='TTable'>
                                <tr><th colspan=4>LLAMADAS</th></tr><tr></tr><tr></tr>
                                <% while (rsL.next())
                                  {
                                      iCont = 2; %>
                                           <tr><td width='150'><%=rsL.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsL.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <td width='150'><%=rsL.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsL.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           </tr>
                                           <tr><td width='150'><%=rsL.getString(iCont)%>: </td><td class='R1Table' width='190'><%=rsL.getString(iCont-1)%></td>
                                           <% iCont = iCont + 2; %>
                                           <td width='150'><%=rsL.getString(iCont)%>: </td><td class='R1Table' width='260'><%=rsL.getString(iCont-1)%></td>
                                           </tr><tr></tr><tr><td colspan='4'>-----------------------------------------------------------------------------------------------------------------------------------------------------------</td></tr>
                                      
                                 <% 
                                  }
                                
                      }
                  }
               
                %>
                <tr><td colspan='2'></td><td align='center'><input type='Button' class='cBtn' value='Imprimir' onclick='window.print();'></td></tr></table>
                <%

     }
    else {
	%><table><tr><td width='450'>NO EXISTE EL EXPEDIENTE</td></tr></table><%
        
    }

    %></form><%
    rs.close();
    rs = null;
    
%>

</body>
</html>



<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%> 
<html>
<head><title>Cauciones</title> 
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<script src='../../Utilerias/UtilMask.js'></script> 
<%  
    String StrclUsrApp="0";

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) 
     {
       %>Fuera de Horario<%
       StrclUsrApp=null; 
       return;        
     }    
    String StrclExpediente = "0";    
    String StrclPaginaWeb = "0";    
    String StrclLlamada = "0";

    if (session.getAttribute("clExpediente")!= null)    
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }      
     if (request.getParameter("clLlamada")!= null)
     {
       StrclLlamada = request.getParameter("clLlamada").toString(); 
     }   
 
    StringBuffer StrSql = new StringBuffer();
    StrSql.append("Select coalesce(LE.FechaLlamada,'') as FechaLlamada, coalesce(LE.NombreAtendio,'') as NombreAtendio,");
    StrSql.append(" coalesce(LE.TelefonoLlamada,'') as TelefonoLlamada,coalesce(PA.dsTipoPersAten,'') as dsTipoPersAten,");
    StrSql.append(" coalesce(LE.clProveedor,'') as clProveedor,coalesce(P.NombreOpe,'') as NombreOpe,coalesce(LE.Observaciones,'') as Observaciones");
    StrSql.append(" From LlamadaxExpediente LE ");
    StrSql.append(" left Join cTipoPersAten PA ON (PA.clTipoPersAten=LE.clTipoPersAten) ");
    StrSql.append(" Inner Join cProveedor P ON (P.clProveedor=LE.clProveedor) ");
    StrSql.append(" Where clLlamada = ").append(StrclLlamada);
    ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
    StrSql.delete(0,StrSql.length());        
 
   %><script>fnOpenLinks()</script><%

   StrclPaginaWeb = "309";       
   MyUtil.InicializaParametrosC(309,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

   session.setAttribute("clPaginaWebP",StrclPaginaWeb);

   %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
   <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="LlamadasxExp.jsp?'>"%><%  

   if (rs.next()) { %>
      <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
      <INPUT id='clLlamada' name='clLlamada' type='hidden' value='<%=StrclLlamada%>'>                
      <%=MyUtil.ObjInput("Fecha Llamada","FechaLlamadaVTR",rs.getString("FechaLlamada"),false,false,30,70,"",false,false,22)%>
      <%=MyUtil.ObjInput("Quien Atendio","NombreAtendio",rs.getString("NombreAtendio"),true,true,220,70,"",true,true,50)%>
      <%=MyUtil.ObjInput("Teléfono","TelefonoLlamada",rs.getString("TelefonoLlamada"),true,true,30,115,"",true,true,30)%>
      <%=MyUtil.ObjComboC("Tipo Persona Atiende","clTipoPersAten",rs.getString("dsTipoPersAten"),true,true,220,115,"","select clTipoPersAten,dsTipoPersAten from cTipoPersAten","","",70,false,false)%>

<%

        
        String strclProveedor=rs.getString("clProveedor");
        %><%=MyUtil.ObjInput("Proveedor","Proveedor",rs.getString("NombreOpe"),true,true,30,160,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=strclProveedor%>'><%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:30; left:350px; top:170px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                } %>
        
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"), "85","4",true,true,30,220,"",false,false)%>
        <%=MyUtil.DoBlock("Datos de la Llamada",110,30)%><%
}
   else { %>
       <script>document.all.btnElimina.disabled=true;document.all.btnCambio.disabled=true;</script>  
       <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                 
       <INPUT id='clLlamada' name='clLlamada' type='hidden' value='<%=StrclLlamada%>'>           
       <%=MyUtil.ObjInput("Quien Atendio","NombreAtendio","",true,true,220,70,"",true,true,50)%>
       <%=MyUtil.ObjInput("Teléfono","TelefonoLlamada","",true,true,30,115,"",true,true,30)%>
       <%=MyUtil.ObjComboC("Tipo Persona Atiende","clTipoPersAten","",true,true,220,115,"","select clTipoPersAten,dsTipoPersAten from cTipoPersAten ","","",70,true,true)%>
       <%=MyUtil.ObjInput("Fecha Llamada","FechaLlamadaVTR","",false,false,30,70,"",false,false,22)%>
       <%=MyUtil.ObjInput("Proveedor","Proveedor","",true,true,30,160,"",true,true,60,"if(this.readOnly==false){fnBuscaProv();}")%>
	<INPUT id='clProveedor' name='clProveedor' type='hidden' value=''><%
                if (MyUtil.blnAccess[4]==true){ %>
                    <div class='VTable' style='position:absolute; z-index:30; left:350px; top:175px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                } %>
       <%=MyUtil.ObjTextArea("Observaciones","Observaciones","", "85","4",true,true,30,200,"",false,false)%>
       <%=MyUtil.DoBlock("Datos de la Llamada",110,30)%><%
    }    
        %><%=MyUtil.GeneraScripts()%><%
        rs.close();
        rs=null;
        StrclExpediente = null;    
        StrSql = null; 
        StrclPaginaWeb=null;    
        StrclLlamada=null;
        StrclUsrApp=null;         
        
 %>
<script> 
     function fnBuscaProv(){
         var pstrCadena = "../../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProv ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.Proveedor.value;
         document.all.clProveedor.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }
  
    function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedor.value = pclProveedor;
        document.all.Proveedor.value = pNombreOperativo;
    }
    </script>
</body>
</html>


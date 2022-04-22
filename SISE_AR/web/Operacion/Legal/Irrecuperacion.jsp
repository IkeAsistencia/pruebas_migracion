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
    String StrclCaucion = "0"; 
    String StrclIrrecuperacion = "0";     
    String StrclPaginaWeb="0";    
    String StrFolioCaucion="";      
    String StrclEstatusCaucion = "0"; 

    if (session.getAttribute("clExpediente")!= null)
     {
       StrclExpediente = session.getAttribute("clExpediente").toString(); 
     }      
    if (session.getAttribute("clCaucion")!= null)
     { 
       StrclCaucion = session.getAttribute("clCaucion").toString(); 
     }      

     if (request.getParameter("clIrrecuperacion")!= null)
     { 
       StrclIrrecuperacion = request.getParameter("clIrrecuperacion").toString(); 
     }      

    StringBuffer StrSql = new StringBuffer();
    StrSql.append("Select coalesce(FolioCaucion,0) as FolioCaucion, clEstatusCaucion ");    
    StrSql.append(" From Caucion  ");
    StrSql.append(" Where clCaucion =").append(StrclCaucion);     
    ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());     
    StrSql.delete(0,StrSql.length());

    if (rs2.next()) {
       StrFolioCaucion=rs2.getString("FolioCaucion"); 
       StrclEstatusCaucion=rs2.getString("clEstatusCaucion");
    } else{
     %><script>alert('Elija una Caución para trabajar');</script><%
     rs2.close();
     rs2=null;
     StrclExpediente =null;    
     StrclCaucion = null; 
     StrclIrrecuperacion = null;     
     StrSql = null; 
     StrclPaginaWeb=null;    
     StrFolioCaucion=null;      
     StrclEstatusCaucion = null; 
     StrclUsrApp=null;
     
     return; 
   }

    StrSql.append(" Select I.clIrrecuperacion, ");
            StrSql.append(" I.clCaucion, ");
            StrSql.append(" I.FolioIrrecuperacion,");
            StrSql.append(" coalesce(convert(varchar(10), I.FechaDeterminacion,120),'') as FechaDeterminacion, ");
            StrSql.append(" coalesce(I.MontoIrrecuperable,0) as MontoIrrecuperable, ");
            StrSql.append(" coalesce(PP.NombreOpe,'') as ProveedorDetermina, ");
            StrSql.append(" coalesce(I.clProveedorDetermina,'') as clProveedorDetermina, ");
            StrSql.append(" coalesce(substring(I.Observaciones,1,2000),'') as Observaciones  ");
            StrSql.append(" from Irrecuperacion I ");
            StrSql.append(" inner join caucion C on (C.clcaucion=I.clcaucion)");
            StrSql.append(" Left Join cProveedor PP ON (PP.clProveedor = I.clProveedorDetermina) ");
            StrSql.append(" Where C.clexpediente=").append(StrclExpediente);

   ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());     
   StrSql.delete(0,StrSql.length());
          
   StrclPaginaWeb = "284";       
   MyUtil.InicializaParametrosC(284,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina

   %><script>fnOpenLinks()</script><%

   
   session.setAttribute("clPaginaWebP",StrclPaginaWeb);  

   %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionIrrecupCaucion","")%>         
   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="Irrecuperacion.jsp?'>"%><% 
   
   if (rs.next()) { %>
       <script>document.all.btnAlta.disabled=true;</script><%
        if (StrclEstatusCaucion.equals("2"))
        {  // No se puede modificar una Caución con estatus CANCELADA
           %><script>document.all.btnCambio.disabled=true;</script><%
        } %>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clIrrecuperacion' name='clIrrecuperacion' type='hidden' value='<%=rs.getString("clIrrecuperacion")%>'>                         
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='<%=rs.getString("clCaucion")%>'>                         
 
        <%=MyUtil.ObjInput("Folio de la Caución","FolioCaucionVTR",StrFolioCaucion,false,false,30,70,StrFolioCaucion,false,false,20)%>
        <%=MyUtil.ObjInput("Folio de Irrecuperación","FolioVTR",rs.getString("FolioIrrecuperacion"),false,false,175,70,"",false,false,20)%>
        <%=MyUtil.ObjInput("Fecha de Determinación <br>(AAAA/MM/DD)","FechaDeterminacion",rs.getString("FechaDeterminacion"),true,false,350,70,"",true,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjInput("Monto Irrecuperable","MontoIrrecuperable",rs.getString("MontoIrrecuperable"),true,true,30,120,"",true,true,15,"EsNumerico(document.all.MontoIrrecuperable)")%>
        
        <%=MyUtil.ObjInput("Abogado que determina","ProveedorDetermina", rs.getString("ProveedorDetermina"),false,false,175,120,"",true,true,60,"")%>
	<INPUT id='clProveedorDetermina' name='clProveedorDetermina' type='hidden' value='<%=rs.getString("clProveedorDetermina")%>'><%
                if (MyUtil.blnAccess[4]==true){ %>
                    <div class='VTable' style='position:absolute; z-index:30; left:495px; top:125px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div><%
                }  %>
        
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"90","7",true,true,30,160,"",false,false)%>
        <%=MyUtil.DoBlock("Datos de la Irrecuperación",0,75)%><%
   }
   else { 
        if (StrclEstatusCaucion.equals("2"))
        {  // No se puede modificar una Caución con estatus CANCELADA
           %><script>document.all.btnCambio.disabled=true;</script><%
        } %>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clIrrecuperacion' name='clIrrecuperacion' type='hidden' value='0'>                        
        <INPUT id='clCaucion' name='clCaucion' type='hidden' value='<%=StrclCaucion%>'>                         
 
        <%=MyUtil.ObjInput("Folio de la Caución","FolioCaucionVTR",StrFolioCaucion,false,false,30,70,StrFolioCaucion,false,false,20)%>
        <%=MyUtil.ObjInput("Folio de Irrecuperación","FolioVTR","",false,false,175,70,"",false,false,20)%>
        <%=MyUtil.ObjInput("Fecha de Determinación <br>(AAAA/MM/DD)","FechaDeterminacion","",true,false,350,70,"",true,false,25,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>                       
        <%=MyUtil.ObjInput("Monto Irrecuperable","MontoIrrecuperable","",true,true,30,120,"",true,true,15,"EsNumerico(document.all.MontoIrrecuperable)")%>

        <%=MyUtil.ObjInput("Abogado que determina","ProveedorDetermina", "",false,false,175,120,"",true,true,60,"")%>
	<INPUT id='clProveedorDetermina' name='clProveedorDetermina' type='hidden' value=''><%
                if (MyUtil.blnAccess[4]==true){ %>
                    <div class='VTable' style='position:absolute; z-index:30; left:495px; top:125px;'>
                    <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaProv();' WIDTH=20 HEIGHT=20></div> <%
                } %>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","90","7",true,true,30,160,"",false,false)%>
        <%=MyUtil.DoBlock("Datos de la Irrecuperación",0,75)%><%
    }    %>

    <%=MyUtil.GeneraScripts()%><%
    rs2.close();
    rs.close();
    rs2=null;
    rs=null;
     StrclExpediente = null;    
     StrclCaucion = null; 
     StrclIrrecuperacion = null;     
     StrSql = null; 
     StrclPaginaWeb=null;    
     StrFolioCaucion=null;      
     StrclEstatusCaucion = null; 
     StrclUsrApp=null;
     
  
 %>
<input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>

<script> 

     function fnBuscaProv(){
         var pstrCadena = "../../Utilerias/FiltrosProv.jsp?strSQL=sp_WebBuscaProv ";
         pstrCadena = pstrCadena + "&NombreOpe= " + document.all.ProveedorDetermina.value;
         document.all.clProveedorDetermina.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }
    
    function fnActualizaProv(pclProveedor, pNombreOperativo){
        document.all.clProveedorDetermina.value = pclProveedor;
        document.all.ProveedorDetermina.value = pNombreOperativo;
    }

</script>

</body>
</html>



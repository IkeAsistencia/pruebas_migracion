<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Datos de Persona Involucrada</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackagAL.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
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
        String StrclPersonaInv = "0";
        String StrclPaginaWeb="0";
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("Select clExpediente From AsistenciaLegal Where clExpediente =").append(StrclExpediente);
        ResultSet rs2 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
        }
        else
        {
        %>No existe Aistencia Legal, debe crearla primero!<%
        rs2.close();
        rs2=null;
        StrclExpediente = null;
        StrclPersonaInv = null;
        StrSql = null;
        StrclPaginaWeb=null;
        StrclUsrApp=null;
        return;
        }
        
        if (request.getParameter("clPersonaInv")!= null)
        {
            StrclPersonaInv= request.getParameter("clPersonaInv").toString();
        }
        
        
        StrSql.append("Select P.clPersonaInv,coalesce(P.Nombre,'') as Nombre, ");
        StrSql.append(" coalesce(CA.dsTipoPersona,'') as dsTipoPersona, coalesce(ES.dsEstatusPersona,'') as dsEstatusPersona, ");
        StrSql.append(" coalesce(P.Lada,'') as Lada, ");
        StrSql.append(" coalesce(P.Telefono,'') as Telefono, ");
        StrSql.append(" coalesce(P.Colonia,'') Colonia, ");
        StrSql.append(" coalesce(M.dsMunDel,'') dsMunDel, ");
        StrSql.append(" coalesce(E.dsEntFed,'') dsEntFed, ");
        StrSql.append(" coalesce(P.CodEnt,'') CodEnt, coalesce(P.CodMD,'') CodMD,");
        StrSql.append(" coalesce(P.CP,'') CP, ");
        StrSql.append(" coalesce(P.Calle,'') Calle ");
        StrSql.append(" From PersonaInvolucrada P ");
        StrSql.append(" Left Join cEstatusPersona ES ON (ES.clEstatusPersona = P.clEstatusPersona) ");
        StrSql.append(" left join cEntFed E on (P.CodEnt=E.CodEnt) ");
        StrSql.append(" left Join cMundel M on (P.CodEnt=M.CodEnt and P.CodMD=M.CodMD) ");
        StrSql.append(" left Join ctipopersona CA on (CA.clTipoPersona=P.clTipoPersona ) ");
        StrSql.append(" Where P.clPersonaInv =").append(StrclPersonaInv);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        %><script>fnOpenLinks()</script><%
        
        StrclPaginaWeb = "190";
        MyUtil.InicializaParametrosC(190,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
        
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>         
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="PersonaInvolucrada.jsp?'>"%><% 
        if (rs.next())
        { %>                        
        <INPUT id='clPersonaInv' name='clPersonaInv' type='hidden' value='<%=StrclPersonaInv%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                
        <%=MyUtil.ObjInput("Nombre","Nombre",rs.getString("Nombre"),true,true,30,70,"", true,true,60)%>           
        <%=MyUtil.ObjComboC("Tipo", "clTipoPersona", rs.getString("dsTipoPersona"),true,true,350,70,"","Select clTipoPersona, dsTipoPersona From ctipopersona","","",60,true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"Lada",rs.getString("Lada"),true,true,510,70,"",false,false,5)%>
        <%=MyUtil.ObjInput("Telefono","Telefono",rs.getString("Telefono"),true,true,560,70,"",false,false,20)%>
        <%=MyUtil.ObjComboC("Estatus", "clEstatusPersona", rs.getString("dsEstatusPersona"),true,true,30,120,"","Select clEstatusPersona, dsEstatusPersona From cEstatusPersona","","",60,true,true)%>
        <%=MyUtil.DoBlock("Persona Involucrada",-30,0)%>  
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),false,false,30,220,"",false,false,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:230px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,190,220,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,30,260,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,300,260,"",false,false,50)%>
        <%=MyUtil.ObjInput("Calle","Calle",rs.getString("Calle"),true,true,30,300,"",false,false,50)%>       
        <%=MyUtil.DoBlock("Domicilio",130,0)%><%
        }
        else
        { %>
        
        <script>document.all.btnCambio.disabled=true;</script>
        <script>document.all.btnElimina.disabled=true;</script>
        <INPUT id='clPersonaInv' name='clPersonaInv' type='hidden' value='<%=StrclPersonaInv%>'>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>                
        
        <%=MyUtil.ObjInput("Nombre","Nombre","",true,true,30,70,"", true,true,60)%>           
        <%=MyUtil.ObjComboC("Tipo", "clTipoPersona","",true,true,350,70,"","Select clTipoPersona, dsTipoPersona From ctipopersona","","",60,true,true)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.lada"),"Lada","",true,true,510,70,"",false,false,5)%>                        
        <%=MyUtil.ObjInput("Telefono","Telefono","",true,true,560,70,"",false,false,20)%>             
        <%=MyUtil.ObjComboC("Estatus", "clEstatusPersona", "",true,true,30,120,"","Select clEstatusPersona, dsEstatusPersona From cEstatusPersona","","",60,true,true)%>                       
        <%=MyUtil.DoBlock("Persona Involucrada",-30,0)%>   
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",false,false,30,220,"",false,false,10)%>               
        <div class='VTable' style='position:absolute; z-index:25; left:100px; top:230px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,190,220,"",false,false,50)%>                
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,30,260,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,300,260,"",false,false,50)%>                
        <%=MyUtil.ObjInput("Calle","Calle","",true,true,30,300,"",false,false,50)%>         
        <%=MyUtil.DoBlock("Domicilio",130,0)%><%
        }    %>
        <%=MyUtil.GeneraScripts()%><%       
        rs.close();
        rs2.close();
        rs=null;
        
        rs2=null;
        StrclExpediente = null;
        StrclPersonaInv = null;
        StrSql = null;
        StrclPaginaWeb=null;
        StrclUsrApp=null;
        %>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09F 00VN09VN09F:00VN00VN00'>
        
        <script>
     document.all.Nombre.maxLength=100; 
     document.all.Telefono.maxLength=20;     
        </script>
    </body>
</html>


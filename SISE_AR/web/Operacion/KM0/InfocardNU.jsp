<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js'></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclUsrApp="0";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        { %>
        Fuera de Horario
        <%
        
        StrclUsrApp=null;
        return;
        }
        String StrclExpediente = "0";
        String StrclPaginaWeb="0";
        String StrFecha ="";
        String StrRFC ="";
        String StrLugNac ="";
        String StrclNuInfoCard = "0";
        String StrEntidadNac ="";
        String StrclInfoCard ="";
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        if (session.getAttribute("RFCInfo")!= null)
        {
            StrRFC = session.getAttribute("RFCInfo").toString();
        }
        if (session.getAttribute("LugNacInfo")!= null)
        {
            StrLugNac = session.getAttribute("LugNacInfo").toString();
        }
        if (session.getAttribute("InfoCard")!= null)
        {
            StrclInfoCard = session.getAttribute("InfoCard").toString();
        }
        
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" Select clExpediente From infocard Where RFC='").append(StrRFC).append("'");
        StrSql.append(" and clInfoCard='").append(StrclInfoCard).append("'");
        
        ResultSet rs4 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs4.next())
        {
        }
        else
        {
            out.println("<script>  alert ('Necesita Registrar INFOCARD'); </script>");
            out.println("<script>location.href='InfocardRegistro.jsp?';</script>");
        }
        
        
        StrSql.append(" Select dsEntFed From cEntFed Where CodEnt='").append(StrLugNac).append("'");
        
        ResultSet rs3 = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs3.next())
        {
            StrEntidadNac = rs3.getString("dsEntFed");
        }
        
        
        StrSql.append("Select NU.clNuInfoCard, ");
        StrSql.append(" coalesce(NU.RFC,'') RFC, ");
        StrSql.append(" coalesce(convert(varchar(10), NU.FechaNacimiento,120),'') as FechaNacimiento, ");
        StrSql.append(" coalesce(ENac.dsEntFed,'') as dsEntFedNac, ");
        StrSql.append(" coalesce(NU.NombreAbuelo,'') as NombreAbuelo, ");
        StrSql.append(" coalesce(NU.GradoEstudios,'') as GradoEstudios, ");
        StrSql.append(" coalesce(NU.EscuelaEgreso,'') as EscuelaEgreso, ");
        StrSql.append(" coalesce(NU.TipoSangre,'') as TipoSangre, ");
        StrSql.append(" coalesce(NU.Enfermedad,'') as Enfermedad, ");
        StrSql.append(" coalesce(ltrim(rtrim(EFact.dsEntFed)),'') as dsEntFed, ");
        StrSql.append(" coalesce(ltrim(rtrim(NU.CodEnt)),'') as CodEnt, ");
        StrSql.append(" coalesce(ltrim(rtrim(MFact.dsMunDel)),'') as dsMunDel, ");
        StrSql.append(" coalesce(ltrim(rtrim(NU.CodMD)),'0') as CodMD, ");
        StrSql.append(" coalesce(ltrim(rtrim(NU.Colonia)),'') as Colonia, ");
        StrSql.append(" coalesce(ltrim(rtrim(NU.CalleNum)),'') as CalleNum, ");
        StrSql.append(" coalesce(ltrim(rtrim(NU.CP)),'') CP, ");
        StrSql.append(" coalesce(ltrim(rtrim(NU.clInfoCard)),'') clInfoCard ");
        StrSql.append(" From NUInfoCard NU ");
        StrSql.append(" left join cEntFed EFact ON (EFact.CodEnt=NU.CodEnt) ");
        StrSql.append(" left join cMunDel MFact ON (MFact.CodMD=NU.CodMD and MFact.CodEnt=NU.CodEnt) ");
        StrSql.append(" left join cEntFed ENac ON (ENac.CodEnt=NU.CodEntNacimiento) ");
        StrSql.append(" Where NU.RFC='").append(StrRFC).append("' and NU.CodEntNacimiento='").append(StrLugNac).append("'");
        
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());
        %>
        <script>fnOpenLinks()</script>
        <%
        StrclPaginaWeb = "389";
        MyUtil.InicializaParametrosC(389,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="InfocardNU.jsp?'>"%>
        <%
        if (rs.next())
        {
            StrclNuInfoCard = rs.getString("clNuInfoCard");
            session.setAttribute("clNUInfoCard",StrclNuInfoCard);
        %>
        <script>document.all.btnAlta.disabled=true;document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clNUInfoCard' name='clNUInfoCard' type='hidden' value='<%=StrclNuInfoCard%>'>
        <INPUT id='clInfoCard' name='clInfoCard' type='hidden' value='<%=StrclInfoCard%>'>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",StrRFC,false,false,30,80,"",true,true,20)%>
        <%=MyUtil.ObjInput("Fecha de Nacimiento <br>(AAAA/MM/DD) ","FechaNacimiento",rs.getString("FechaNacimiento"),true,true,160,70,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Lugar de Nacimiento","CodEntNacimiento",StrEntidadNac,false,false,350,80,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,false,false)%>
        <%=MyUtil.ObjInput("Nombre de Abuelo","NombreAbuelo",rs.getString("NombreAbuelo"),true,true,30,120,"",false,false,100)%>
        <%=MyUtil.ObjInput("Grado de Estudios","GradoEstudios",rs.getString("GradoEstudios"),true,true,30,160,"",false,false,50)%>
        <%=MyUtil.ObjInput("Tipo de Sangre","TipoSangre",rs.getString("TipoSangre"),true,true,350,160,"",false,false,20)%>
        <%=MyUtil.ObjInput("Egresado de Escuela","EscuelaEgreso",rs.getString("EscuelaEgreso"),true,true,30,200,"",false,false,100)%>
        <%=MyUtil.ObjInput("Enfermedad / Alergia","Enfermedad",rs.getString("Enfermedad"),true,true,30,240,"",false,false,130)%>
        <%=MyUtil.DoBlock("Claves de Seguridad",180,0)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,25,320,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%=rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,380,320,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%=rs.getString("CodMD")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,25,360,"",false,false,50)%>
        <%=MyUtil.ObjInput("Calle","CalleNum",rs.getString("CalleNum"),true,true,380,360,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),false,false,25,400,"",false,false,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:130px; top:410px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.DoBlock("DOMICILIO DE FACTURACIÓN",155,0)%>
        <%
        
        }
        else
        {
        %>
        <script>document.all.btnCambio.disabled=true;document.all.btnElimina.disabled=true;</script>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        <INPUT id='clNUInfoCard' name='clNUInfoCard' type='hidden' value=''>
        <INPUT id='clInfoCard' name='clInfoCard' type='hidden' value='<%=StrclInfoCard%>'>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",StrRFC,false,false,30,80,StrRFC,true,true,20)%>
        <%=MyUtil.ObjInput("Fecha de Nacimiento <br>(AAAA/MM/DD) ","FechaNacimiento","",true,true,160,70,"",true,true,20,"if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)}")%>
        <%=MyUtil.ObjComboC("Lugar de Nacimiento","CodEntNacimiento",StrEntidadNac,false,false,350,80,StrLugNac,"Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,false,false)%>
        <%=MyUtil.ObjInput("Nombre de Abuelo","NombreAbuelo","",true,true,30,120,"",false,false,100)%>
        <%=MyUtil.ObjInput("Grado de Estudios","GradoEstudios","",true,true,30,160,"",false,false,50)%>
        <%=MyUtil.ObjInput("Tipo de Sangre","TipoSangre","",true,true,350,160,"",false,false,20)%>
        <%=MyUtil.ObjInput("Egresado de Escuela","EscuelaEgreso","",true,true,30,200,"",false,false,100)%>
        <%=MyUtil.ObjInput("Enfermedad / Alergia","Enfermedad","",true,true,30,240,"",false,false,130)%>
        <%=MyUtil.DoBlock("Claves de Seguridad",180,0)%>
        
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,25,320,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,380,320,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,25,360,"",false,false,50)%>
        <%=MyUtil.ObjInput("Calle","CalleNum","",true,true,380,360,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP","",false,false,25,400,"",false,false,10)%>
        <div class='VTable' style='position:absolute; z-index:25; left:130px; top:410px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaN2();' class='cBtn'></div>
        <%=MyUtil.DoBlock("DOMICILIO DE FACTURACIÓN",155,0)%>
        <%
        }
        
        rs3.close();
        rs4.close();
        rs.close();
        rs3=null;
        rs4=null;
        rs=null;
        StrclExpediente = null;
        StrSql = null;
        StrclPaginaWeb=null;
        StrFecha =null;
        StrRFC =null;
        StrLugNac =null;
        StrclNuInfoCard = null;
        StrclInfoCard=null;
        StrEntidadNac =null;  
        
        %>
        <%=MyUtil.GeneraScripts()%>
        <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        <script>
     document.all.NombreAbuelo.maxLength=100;   
     document.all.GradoEstudios.maxLength=50;   
     document.all.EscuelaEgreso.maxLength=100;  
     document.all.TipoSangre.maxLength=20;   
     document.all.Enfermedad.maxLength=100;  
     document.all.CalleNum.maxLength=100; 
     document.all.Colonia.maxLength=50;  
     document.all.CP.maxLength=5;  
        </script>
    </body>
</html>

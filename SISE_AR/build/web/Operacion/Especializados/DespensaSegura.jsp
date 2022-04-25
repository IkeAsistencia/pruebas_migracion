<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Combos.cbEntidad,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>
        <script src='../../Utilerias/Util.js'></script>
        <script src='../../Utilerias/UtilMask.js'></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String strclUsr = "0";
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        if (SeguridadC.verificaHorarioC(Integer.parseInt(strclUsr)) != true)
            
        {%>
        Fuera de Horario
        <%
        strclUsr=null;
        return;
        }
        String StrclExpediente = "0";
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        // checar si ya existe asistencia para el expediente, si existe, ya no procede la alta
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" select E.TieneAsistencia, E.Contacto,E.clTipoContactante, TC.dsTipoContactante,E.Telefono1,E.Telefono2,E.NuestroUsuario, ");
        StrSql.append(" E.clave,'Vigencia' as Vigencia " );
        StrSql.append(" From Expediente E");
        StrSql.append(" inner join ctipocontactante TC on (E.clTipoContactante=TC.clTipoContactante) ");
        StrSql.append(" Where clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        if (rs2.next())
        {
            StrSql.append("select Ds.CodEnt, EF.dsEntFed,Ds.CodMD,MU.dsMunDel,Ds.NombreTitular, ");
            StrSql.append("	Ds.clBanco,BK.Nombre,Ds.Sucursal,Ds.Clabe,Ds.NumCuenta  ");
            StrSql.append("from ADespensaseg Ds ");
            StrSql.append("inner join cEntFed EF on (Ds.CodEnt=EF.CodEnt) ");
            StrSql.append(" left  join cMunDel MU on (Ds.CodEnt=MU.CodEnt and MU.CodMD=Ds.codMD) ");
            StrSql.append(" inner join cBanco BK on (BK.clBanco=Ds.clbanco) ");
            
            StrSql.append(" Where Ds.clExpediente= ").append(StrclExpediente);
            
        }
        else
        {
        %>
        El expediente no existe
        <%
        rs2.close();
        rs2=null;
        StrclExpediente = null;
        StrSql =null;
        strclUsr=null;
        return;
        }
        
        String StrdsEntFed = "";
        String StrdsMunDel = "";
        
        String StrclPaginaWeb = "595";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <script>fnOpenLinks()</script>
        <%
        MyUtil.InicializaParametrosC(595,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccionAsist","")%>
        <%
        if(rs2.getString("TieneAsistencia").compareToIgnoreCase("1")==0)
        {%>
        <script>document.all.btnAlta.disabled=true;</script>
        <%
        }
        else
        {%>
        <script>document.all.btnCambio.disabled=true;</script>
        <%
        }
        
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());
        %>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DespensaSegura.jsp?'>"%>
        <%
        
        
        if (rs.next())
        {
            
            StrdsEntFed = rs.getString("dsEntFed");
            if (StrdsEntFed ==null)
            {
                StrdsEntFed = "";
            }
            
            StrdsMunDel = rs.getString("dsmundel");
            if (StrdsMunDel ==null)
            {
                StrdsMunDel = "";
            }%>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Quien Reporta","Contacto",rs2.getString("Contacto"),false,false,30,80,rs2.getString("Contacto"),false,false,40)%>
        <%=MyUtil.ObjComboC("Parentesco","clTipoContactante",rs2.getString("dsTipoContactante"),false,false,270,80,rs2.getString("clTipoContactante"),"select * from cTipoContactante order by dsTipoContactante","","",15,false,false)%>
        <%=MyUtil.ObjInput("Tel Contacto","Telefono1",rs2.getString("Telefono1"),false,false,445,80,rs2.getString("Telefono1"),false,false,20)%>
        <%=MyUtil.ObjInput("Tel Movil","Telefono2",rs2.getString("Telefono2"),false,false,575,80,rs2.getString("Telefono2"),false,false,20)%>
        <%=MyUtil.ObjInput("Nombre Usuario","NuestroUsuario",rs2.getString("NuestroUsuario"),false,false,30,120,rs2.getString("NuestroUsuario"),false,false,40)%>
        <%=MyUtil.ObjInput("Poliza","Clave",rs2.getString("Clave"),false,false,270,120,rs2.getString("Clave"),false,false,40)%>
        <%--=MyUtil.ObjInput("Vigencia","VigenciaVrt",rs2.getString("Vigencia"),false,false,500,120,rs2.getString("Vigencia"),false,false,27)--%>
        <%=MyUtil.DoBlock("Datos Generales")%>                              
        
        <%=MyUtil.ObjInput("Titular","NombreTitular",rs.getString("NombreTitular"),true,true,30,210,"",true,true,40)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",StrdsEntFed,true,true,30,250,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosOper()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD",StrdsMunDel,true,true,280,250,"","Select CodMD, dsMunDel from cMunDel where CodMD='" + rs.getString("CodMD") + "' and CodEnt='"+ rs.getString("CodEnt") +"' order by dsMunDel ","","",30,true,true)%> 
        <%=MyUtil.ObjComboC("Banco","clBanco",rs.getString("Nombre"),true,true,30,290,"","Select clbanco,nombre from cbanco order by nombre ","","",40,true,true)%>
        <%=MyUtil.ObjInput("Sucursal","Sucursal",rs.getString("Sucursal"),true,true,280,290,"",true,true,40)%>
        <%=MyUtil.ObjInput("CLABE","Clabe",rs.getString("Clabe"),true,true,30,330,"",true,true,30)%>
        <%=MyUtil.ObjInput("Número de Cuenta","NumCuenta",rs.getString("NumCuenta"),true,true,280,330,"",true,true,40)%>
        <%=MyUtil.DoBlock("Detalle Despensa Segura",90,0)%>
        <%       }
        else
        {   
        %>
        
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
        
        <%=MyUtil.ObjInput("Quien Reporta","Contacto",rs2.getString("Contacto"),false,false,30,80,rs2.getString("Contacto"),false,false,40)%>
        <%=MyUtil.ObjComboC("Parentesco","clTipoContactante",rs2.getString("dsTipoContactante"),false,false,270,80,rs2.getString("clTipoContactante"),"select * from cTipoContactante order by dsTipoContactante","","",15,false,false)%>
        <%=MyUtil.ObjInput("Tel Contacto","Telefono1",rs2.getString("Telefono1"),false,false,445,80,rs2.getString("Telefono1"),false,false,20)%>
        <%=MyUtil.ObjInput("Tel Movil","Telefono2",rs2.getString("Telefono2"),false,false,575,80,rs2.getString("Telefono2"),false,false,20)%>
        <%=MyUtil.ObjInput("Nombre Usuario","NuestroUsuario",rs2.getString("NuestroUsuario"),false,false,30,120,rs2.getString("NuestroUsuario"),false,false,40)%>
        <%=MyUtil.ObjInput("Poliza","Clave",rs2.getString("Clave"),false,false,270,120,rs2.getString("Clave"),false,false,40)%>
        <%--=MyUtil.ObjInput("Vigencia","VigenciaVrt",rs2.getString("Vigencia"),false,false,500,120,rs2.getString("Vigencia"),false,false,27)--%>
        <%=MyUtil.DoBlock("Datos Generales")%>                                                 
        
        <%=MyUtil.ObjInput("Titular","NombreTitular","",true,true,30,210,"",true,true,40)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,true,30,250,"","Select CodEnt, dsEntFed from cEntFed order by dsEntFed ","fnLlenaMunicipiosOper()","",40,true,true)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD","",true,true,280,250,"","Select CodMD, dsMunDel from cMunDel where CodMD='' and CodEnt='' order by dsMunDel ","","",30,true,true)%>                                                                  
        <%=MyUtil.ObjComboC("Banco","clBanco","",true,true,30,290,"","Select clbanco,nombre from cbanco order by nombre ","","",40,true,true)%>
        <%=MyUtil.ObjInput("Sucursal","Sucursal","",true,true,280,290,"",true,true,40)%>
        <%=MyUtil.ObjInput("CLABE","Clabe","",true,true,30,330,"",true,true,30)%>
        <%=MyUtil.ObjInput("Número de Cuenta","NumCuenta","",true,true,280,330,"",true,true,40)%>
        <%=MyUtil.DoBlock("Detalle Despensa Segura",90,0)%>
        <%
        } 
        
        %>
        
        <%
        rs.close();
        rs=null;
        rs2.close();
        rs2=null;
        StrclExpediente = null;
        StrSql=null;
        strclUsr=null;   %>     
        
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>


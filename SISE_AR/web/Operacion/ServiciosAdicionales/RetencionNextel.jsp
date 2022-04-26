<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<html>
    <head><title>JSP Page</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilDireccion.js' ></script>
        <script src='../../Utilerias/UtilAuto.js' ></script>
        
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String StrclUsrApp="0";
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true)
        {
        %>
        Fuera de Horario<% 
        StrclUsrApp=null;
        return;
        }
        
        String StrclLlamada = "0";
        String StrclPaginaWeb="0";
        String StrFecha="";
        
        if (request.getParameter("clLlamada") != null)
        {
            StrclLlamada = request.getParameter("clLlamada");
        }
        
        ResultSet rs3 = UtileriasBDF.rsSQLNP( "Select convert(varchar(20),getdate(),120) FechaApertura ");
        if (rs3.next())
        {
            StrFecha = rs3.getString("FechaApertura");
        }
        
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("Select l.clLlamada, ");
        StrSql.append(" coalesce(convert(varchar(20), l.FechaIni,120),'') as FechaIni, ");
        StrSql.append(" coalesce(convert(varchar(20), l.FechaFin,120),'') as FechaFin, ");
        StrSql.append(" coalesce(ml.dsMotivoLlamada,'') as dsMotivoLlamada, ");
        StrSql.append(" coalesce(l.PersonaReporta,'') as PersonaReporta, ");
        StrSql.append(" coalesce(l.TelPersonaReporta,'') as TelPersonaReporta, ");
        StrSql.append(" coalesce(e.dsEntFed,'') as dsEntFed, ");
        StrSql.append(" coalesce(l.NoNextelMasterPin,'') as NoNextelMasterPin, ");
        StrSql.append(" coalesce(emp.dsEmpresa,'') as dsEmpresa, ");
        StrSql.append(" coalesce(emp.clEmpresaNextel,'') as clEmpresaNextel, ");
        StrSql.append(" coalesce(emp.RepLegal,'') as RepLegal, ");
        StrSql.append(" coalesce(l.Observaciones,'') as Observaciones, ");
        StrSql.append(" coalesce(mc.dsMotivoCancela,'') as dsMotivoCancela ");
        StrSql.append(" From ");
        StrSql.append(" LlamadaNextel l ");
        StrSql.append(" left join cMotivoLlamada ml ON (l.clMotivoLlamada=ml.clMotivoLlamada) ");
        StrSql.append(" left join cMotivoCancela mc ON (l.clMotivoCancela=mc.clMotivoCancela) ");
        StrSql.append(" left join cEntFed e ON (e.CodEnt=l.CodEnt) ");
        StrSql.append(" left join cEmpresaNextel emp ON (l.clEmpresaNextel=emp.clEmpresaNextel) ");
        StrSql.append(" Where l.clLlamada =").append(StrclLlamada);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        //out.println(StrSql.toString());
        %><script>fnOpenLinks()</script><%				
        
        StrclPaginaWeb = "401";
        MyUtil.InicializaParametrosC(401,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
        
        %><%=MyUtil.doMenuAct("../../servlet/Utilerias.EjecutaAccion","","fnAntesGuardar();")%>         
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="RetencionNextel.jsp?'>"%><%  
        if (rs.next())
        {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
        %><INPUT id='clLlamada' name='clLlamada' type='hidden' value='<%=StrclLlamada%>'>  
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>  
        
        <%=MyUtil.ObjInput("Fecha Apertura","FechaIni",rs.getString("FechaIni"),false,false,250,70,StrFecha,false,false,25)%>                
        <%=MyUtil.ObjInput("Fecha Registro","FechaFinVTR",rs.getString("FechaFin"),false,false,400,70,"",false,false,25)%>              
        
        <%=MyUtil.ObjComboC("Motivo de la Llamada","clMotivoLlamada",rs.getString("dsMotivoLlamada"),true,true,30,70,"","Select clMotivoLlamada, dsMotivoLlamada From cMotivoLlamada Where clMotivoLlamada in(9,11,14) Order by dsMotivoLlamada","fnCancelando()","",100,false,false)%>
        <%=MyUtil.ObjInput("Persona que Reporta","PersonaReporta",rs.getString("PersonaReporta"),true,true,30,110,"",false,false,80)%>
        <%=MyUtil.ObjInput("Tel�fono de Contacto","TelPersonaReporta",rs.getString("TelPersonaReporta"),true,true,30,150,"",false,false,20)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt",rs.getString("dsEntFed"),true,true,200,150,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,false,false)%>
        <%=MyUtil.ObjInput("Master Pin/N�m. Nextel","NoNextelMasterPin",rs.getString("NoNextelMasterPin"),true,true,400,150,"",false,false,20)%>
        <%
        //<%=MyUtil.ObjComboC("Empresa","clEmpresaNextel",rs.getString("dsEmpresa"),true,true,30,190,"","Select clEmpresaNextel, dsEmpresa From cEmpresaNextel","","",100,false,false)
        %>
        
        <%=MyUtil.ObjInput("Empresa","dsEmpresa",rs.getString("dsEmpresa"),true,false,30,190,"",true,true,60,"if(this.readOnly==false){fnBuscaEmpresa();}")%>
        <INPUT id='clEmpresaNextel' name='clEmpresaNextel' type='hidden' value='<%=rs.getString("clEmpresaNextel")%>'><%
        if (MyUtil.blnAccess[4]==true)
        {
        %><div class='VTable' style='position:absolute; z-index:30; left:350px; top:200px;'>
        <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaEmpresa();' WIDTH=20 HEIGHT=20></div> <%
        } %>            
        
        <%=MyUtil.ObjInput("Representante Legal","RepLegal",rs.getString("RepLegal"),false,false,400,190,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones",rs.getString("Observaciones"),"55","4",true,true,30,230,"",false,false)%>
        <%=MyUtil.ObjComboC("Motivo de la Cancelaci�n","clMotivoCancela",rs.getString("dsMotivoCancela"),true,true,30,300,"","Select clMotivoCancela, dsMotivoCancela From cMotivoCancela Where clCuenta=167 Order by dsMotivoCancela","","",100,false,false)%><% 
        }
        else
        {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
        %><INPUT id='clLlamada' name='clLlamada' type='hidden' value=''>  
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=StrclUsrApp%>'>  
        
        <%=MyUtil.ObjInput("Fecha Apertura","FechaIni","",false,false,250,70,StrFecha,false,false,25)%>                
        <%=MyUtil.ObjInput("Fecha Registro","FechaFinVTR","",false,false,400,70,"",false,false,25)%>              
        
        <%=MyUtil.ObjComboC("Motivo de la Llamada","clMotivoLlamada","",true,true,30,70,"","Select clMotivoLlamada, dsMotivoLlamada From cMotivoLlamada Where clMotivoLlamada in(9,11,14) Order by dsMotivoLlamada","fnCancelando()","",100,false,false)%>
        <%=MyUtil.ObjInput("Persona que Reporta","PersonaReporta","",true,true,30,110,"",false,false,80)%>
        <%=MyUtil.ObjInput("Tel&eacute;fono de Contacto","TelPersonaReporta","",true,true,30,150,"",false,false,20)%>
        <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,true,200,150,"","Select CodEnt, dsEntFed From cEntFed Order by dsEntFed","","",70,false,false)%>
        <%=MyUtil.ObjInput("Master Pin/N�m. Nextel","NoNextelMasterPin","",true,true,400,150,"",false,false,20)%>
        <%
        //<%=MyUtil.ObjComboC("Empresa","clEmpresaNextel",rs.getString("dsEmpresa"),true,true,30,190,"","Select clEmpresaNextel, dsEmpresa From cEmpresaNextel","","",100,false,false)
        %>
        <%=MyUtil.ObjInput("Empresa","dsEmpresa","",true,false,30,190,"",true,true,60,"if(this.readOnly==false){fnBuscaEmpresa();}")%>
        <INPUT id='clEmpresaNextel' name='clEmpresaNextel' type='hidden' value=''><%
        if (MyUtil.blnAccess[4]==true)
        {
        %><div class='VTable' style='position:absolute; z-index:30; left:350px; top:200px;'>
        <IMG SRC='../../Imagenes/Lupa.gif' class='handM' onClick='fnBuscaEmpresa();' WIDTH=20 HEIGHT=20></div> <%
        } %>            
        <%=MyUtil.ObjInput("Representante Legal","RepLegal","",false,false,400,190,"",false,false,50)%>
        <%=MyUtil.ObjTextArea("Observaciones","Observaciones","","55","4",true,true,30,230,"",false,false)%>
        <%=MyUtil.ObjComboC("Motivo de la Cancelaci�n","clMotivoCancela","",true,true,30,300,"","Select clMotivoCancela, dsMotivoCancela From cMotivoCancela Where clCuenta=167 Order by dsMotivoCancela","","",100,false,false)%><% 
        }  %>            
        <%=MyUtil.DoBlock("Detalle de Llamadas Nextel",90,0)%>     
        <%=MyUtil.GeneraScripts()%><%
        
        rs3.close();
        rs.close();
        rs3=null;
        rs=null;
        StrSql = null;
        StrclPaginaWeb=null;
        StrFecha=null;
        StrclUsrApp=null;
        
        %>
        
        <script>
     document.all.PersonaReporta.maxLength=100; 
     document.all.TelPersonaReporta.maxLength=20;   
     document.all.NoNextelMasterPin.maxLength=20;   

     function fnBuscaEmpresa(){
         var pstrCadena = "../../Utilerias/FiltrosEmpresas.jsp?strSQL=sp_WebBuscaEmpresa ";
         pstrCadena = pstrCadena + "&dsEmpresa= " + document.all.dsEmpresa.value;
         document.all.clEmpresaNextel.value='';
         window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
    }

    function fnActualizaEmpresa(pclEmpresa, pNombreEmpresa, pRepLegal){
        document.all.clEmpresaNextel.value = pclEmpresa;
        document.all.dsEmpresa.value = pNombreEmpresa;
        document.all.RepLegal.value = pRepLegal;
        top.frames[5].frames[1].location.href='http://' + top.frames[5].frames[1].location.host + top.frames[5].frames[1].location.pathname + '?clEmpresa=' + pclEmpresa;
    }    
    
    function fnAntesGuardar()
    {
      if (document.all.clMotivoLlamada.value == 11)  
       {    
            if(document.all.NoNextelMasterPin.value.length<4){
               msgVal=msgVal + " Master Pin de 4 d�gitos ";            
            } 
       }   
    }
    
    function fnCancelando()
    {
      if (document.all.clMotivoLlamada.value == 11)  
       {    
          alert('La persona que reporta debe ser el Representante Legal');
       }   
    }    
        </script>
        
    </body>
</html>

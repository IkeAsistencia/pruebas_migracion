<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Connection,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>

<html>
    <head><title>Detalle Colaborador</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <%  
        String StrclColaborador = "0";
        String StrclUsrApp="0";
        
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
        Fuera de Horario
        <%
        return;
        }
        
        if (request.getParameter("clColaborador") != null) {
            StrclColaborador = request.getParameter("clColaborador");
        }
        
        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" select HD.clColaborador, U.Nombre NombreUsr, HD.clUsrApp, ");
        StrSql.append(" AE.dsAreaAtencion, ");
        StrSql.append(" case when HD.Estatus = 0 then 'Inactivo' else 'Activo' end Estatus ");
        StrSql.append(" From HDcColaborador HD ");
        StrSql.append(" inner join cUsrApp U on (U.clUsrApp = HD.clUsrApp) ");
        StrSql.append(" inner join HDcAreaAtencion AE on (AE.clAreaAtencion = HD.clAreaAtencion) ");
        StrSql.append(" Where clColaborador=").append(StrclColaborador);
        
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
        String StrclPaginaWeb = "463";
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        
        MyUtil.InicializaParametrosC( 463,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleColaborador.jsp?'>"%>
        <%       
        if (rs.next()) {
            // El siguiente campo llave no se mete con MyUtil.ObjInput
        %>
        <INPUT id='clColaborador' name='clColaborador' type='hidden' value='<%=StrclColaborador%>'><br>
        <%=MyUtil.ObjInput("Nombre del Colaborador","Nombre",rs.getString("Nombre"),true,true,20,100,"",true,true,70)%>
        <%=MyUtil.ObjInput("Nombre del Usuario Relacionado","NombreUsr",rs.getString("NombreUsr"),true,true,20,140,"",true,true,70,"if(this.readOnly==false){fnBuscaUsuario();}")%>
        <%=MyUtil.ObjComboC("Area de Atencion","clAreaAtencion",rs.getString("dsAreaAtencion"),true,true,20,180,"0","Select clAreaAtencion, dsAreaAtencion from HDcAreaAtencion order by dsAreaAtencion  ","","",20,true,true)%>
        <%=MyUtil.ObjInput("Fecha Baja","FechaBajaVTR",rs.getString("FechaBaja"),false,false,150,220,"",false,false,20,"")%>
        <%=MyUtil.ObjComboC("Estatus","Estatus",rs.getString("Estatus"),true,true,280,220,"0","Select 0, 'Inactivo' union select 1, 'Activo' ","","",20,true,true)%>
        <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value="<%=rs.getString("clUsrApp")%>"></INPUT>
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:155px;'>
        <IMG class='handM' SRC='../Imagenes/Lupa.gif' onClick='fnBuscaUsuario();' WIDTH=20 HEIGHT=20></div>
        <%
        } else {  
        %>
        <%=MyUtil.ObjInput("Nombre del Colaborador","Nombre","",true,true,20,100,"",true,true,70)%>
        <%=MyUtil.ObjInput("Nombre del Usuario Relacionado","NombreUsr","",true,true,20,140,"",true,true,70,"if(this.readOnly==false){fnBuscaUsuario();}")%>
        <%=MyUtil.ObjComboC(" Area de Atencion","clAreaAtencion","",true,true,20,180,"0","Select clAreaAtencion, dsAreaAtencion from HDcAreaAtencion order by dsAreaAtencion  ","","",20,true,true)%>
        <%=MyUtil.ObjComboC("Estatus","Estatus","",true,true,280,220,"0","Select 0, 'Inactivo' union select 1, 'Activo' ","","",20,true,true)%>
        <INPUT id='clUsrAppRel' name='clUsrAppRel' type='hidden' value="<%=0%>"></INPUT>
        <div class='VTable' style='position:absolute; z-index:25; left:400px; top:155px;'>
        <IMG class='handM' SRC='../Imagenes/Lupa.gif' onClick='fnBuscaUsuario();' WIDTH=20 HEIGHT=20></div>
        <%
        }
        
        
        %>
        <%=MyUtil.DoBlock("Detalle de Colaborador",0,0)%>
        <%=MyUtil.GeneraScripts()%> 
        
        
        <%
        
        StrclUsrApp = null;
        StrclColaborador=null;
        StrclPaginaWeb=null;
                
        StrSql=null;
        
        if(rs!=null){
            rs.close();
            rs=null;
        } 
        
        
        %>
        
        
        <script>
    function fnBuscaUsuario(){
        if (document.all.NombreUsr.value!=''){
           var pstrCadena = "../Utilerias/FiltroUsuario.jsp?strSQL=sp_WebBuscaUsuario ";
           pstrCadena = pstrCadena + "&NombreUsr= " + document.all.NombreUsr.value;
           document.all.clUsrAppRel.value='';
           window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
        }
    }
  function fnActualizaDatosUsuario(pNombre, pclUsrApp){
    document.all.NombreUsr.value = pNombre;			
    document.all.clUsrAppRel.value = pclUsrApp;
  }
        </script>
        
    </body>
</html>
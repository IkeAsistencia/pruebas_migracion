<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF,com.ike.Supervision.DAOSCSDeficiencia,com.ike.Supervision.to.SCSDeficiencia" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head>
        <title>
            Deficiencias
        </title> 
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        
        <%
        String StrclDeficienciaxAsistencia = "0";
        String StrclUsrApp = "0";
        String StrclAsistencia = "0";
        String StrclEstatusDef = "0";
        String StrclQuejaxSupervision = "0";
        String StrclQuejaxSupervisionI = "0";
        String StrclPaginaWeb = "6115";
        String StrclAreaDef = "0";
        String StrclDeficiencia = "0";
        String StrclAreaDeficiencia = "-1";
        String StrclAreaOperativa = "3";
        
        DAOSCSDeficiencia daoDeficiencia = null;
        SCSDeficiencia Deficiencia = null;
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
        return;
        }
        
        if (request.getParameter("clDeficienciaxAsistencia") != null) {
            StrclDeficienciaxAsistencia = request.getParameter("clDeficienciaxAsistencia");
        }
        
        if (session.getAttribute("clAsistencia")!= null) {
            StrclAsistencia= session.getAttribute("clAsistencia").toString();
        }
        
        if (request.getParameter("clQuejaxSupervision") != null) {
            StrclQuejaxSupervision = request.getParameter("clQuejaxSupervision");
        }
        daoDeficiencia = new DAOSCSDeficiencia();
        Deficiencia = daoDeficiencia.getSCSDeficiencia(StrclDeficienciaxAsistencia);
        
        if(!StrclDeficienciaxAsistencia.equalsIgnoreCase("0")){
            
            if(Deficiencia.getClAreaDef() != null){
                StrclAreaDef = Deficiencia.getClAreaDef();
            }
            
            if(Deficiencia.getClDeficiencia() != null){
                StrclDeficiencia = Deficiencia.getClDeficiencia();
            }
            
            if(Deficiencia.getClEstatusDef() != null){
                StrclEstatusDef = Deficiencia.getClEstatusDef();
            }
            
            if(Deficiencia.getClAreaDeficiencia() != null){
                StrclAreaDeficiencia = Deficiencia.getClAreaDeficiencia();
            }
        }

        StringBuffer StrSql = new StringBuffer();
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        MyUtil.InicializaParametrosC(6115,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
        %><script>fnOpenLinks();</script>
        <%=MyUtil.doMenuActPost("../servlet/Utilerias.EjecutaAccion","","")%>         
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1) + "DetalleMarcaDeficienciasAsist.jsp?"%>'>
        <INPUT id='clDeficienciaxAsistencia' name='clDeficienciaxAsistencia' type='hidden' value='<%= StrclDeficienciaxAsistencia%>'>
        <%
        if (Integer.parseInt(StrclEstatusDef)!=1){    //Valida si esta concluido o justificado
			StrSql.append("st_SCSgetPCambioAsist ").append(StrclUsrApp);
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
            if (rs.next()){
                if (rs.getString("Permiso").compareToIgnoreCase("0")==0){  //valida si tiene permisos de cambiar deficiencia justificadas o concluidas
					%><script>
						document.all.btnCambio.disabled=true;
						document.all.btnElimina.disabled=true;
					</script><%
					}
				}
			rs.close();
			rs=null; 
			} %>
        <INPUT id='clAsistencia' name='clAsistencia' type='hidden' value='<%= StrclAsistencia %>'>
        <INPUT id='clUsrAppMarca' name='clUsrAppMarca' type='hidden' value='<%= StrclUsrApp %>'>
        <INPUT id='clQuejaxSupervision' name='clQuejaxSupervision' type='hidden' value='<%= StrclQuejaxSupervision%>'>
        <%=MyUtil.ObjComboC("Tipo de Deficiencia", "clTipoDeficienciaVTR", Deficiencia != null ? Deficiencia.getDsTipoDeficiencia() : "",true,true,30,70,"","SELECT clTipoDeficiencia,dsTipoDeficiencia  FROM SCScTipoDeficiencia","fnLlenaAreas();","",50,true,true)%>
        <%=MyUtil.ObjComboC("ÁREA", "clAreaDef", Deficiencia != null ? Deficiencia.getDsAreaDefiencia() : "",true,true,30,110,"","SELECT clAreaDeficiencia,dsAreaDefiencia from SCScAreaDeficiencia where clAreaDeficiencia=" + StrclAreaDef,"fnLlenaDeficiencias();","",50,true,true)%>
        <%=MyUtil.ObjComboC("Coordinador con Deficiencia ", "clUsrAppDef", Deficiencia != null ? Deficiencia.getUsrDeficiencia() : "",true,true,280,110,"","st_SCSLlenaComboUsrDef " + StrclAsistencia,"","",50,false,false)%>
        <%=MyUtil.ObjComboC("Referencia con Deficiencia", "clReferenciaDef", Deficiencia != null ? Deficiencia.getReferencia() : "",true,true,280,110,"","st_SCSLlenaComboRefxAsist " + StrclAsistencia,"","",50,false,false)%>
        <%=MyUtil.ObjComboC("Deficiencia", "clDeficiencia", Deficiencia != null ? Deficiencia.getDsDeficiencia() : "",true,true,30,150,"","select * from SCScDeficiencias where clDeficiencia=" +  StrclDeficiencia,"","",50,true,true)%>
        <%=MyUtil.ObjTextArea("Observaciones del Supervisor","ObservacionesSup", Deficiencia != null ? Deficiencia.getObservacionesSup() : "","100","5",true,true,30,190,"",false,false)%>
        <%=MyUtil.ObjComboC("Estatus Deficiencia", "clEstatusDef", Deficiencia != null ? Deficiencia.getDsEstatusDef() : "",false,true,30,280,"1","SELECT clEstatusDef,dsEstatusDef FROM CESTATUSDEF","","",50,false,true)%>
        <%=MyUtil.DoBlock("Detalle de Marca Deficiencias",450,0)%>
        <%=MyUtil.GeneraScripts()%>
        <%
        StrclDeficienciaxAsistencia = null;
        StrclUsrApp = null;
        StrclAsistencia = null;
        StrclEstatusDef = null;
        StrclQuejaxSupervision = null;
        StrclQuejaxSupervisionI = null;
        StrclPaginaWeb = null;
        StrSql = null;
        %>
        
        <script>
            
            function fnLlenaAreas(){
                var Tipo= document.all.clTipoDeficienciaVTR.value;
 
                var strConsulta = "st_SCSLlenaAreaDef " + document.all.clTipoDeficienciaVTR.value;
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clAreaDef.value = '';
                pstrCadena = pstrCadena + "&strName=clAreaDefC";		
                fnOptionxDefault('clAreaDefC',pstrCadena);
                
                  var Tipo= eval(document.all.clTipoDeficienciaVTR.value);
                switch (Tipo){
                    case 1:    //Coordinador
                        document.all.D5.style.visibility='visible';
                        document.all.D6.style.visibility='hidden';
                        break;
                    case 2:      //Referencia
                        document.all.D5.style.visibility='hidden';
                        document.all.D6.style.visibility='visible';
                        break;
                    case 3:    //Area
                        document.all.D5.style.visibility='hidden';
                        document.all.D6.style.visibility='hidden';
                        break; 
                }
            }

            function fnLlenaDeficiencias(){
                var strConsulta = "st_SCSLlenaDeficiencias " + document.all.clAreaDef.value + "," + document.all.clTipoDeficienciaVTR.value;
                var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
                document.all.clDeficiencia.value = '';
                pstrCadena = pstrCadena + "&strName=clDeficienciaC";
                fnOptionxDefault('clDeficienciaC',pstrCadena);
                }
            
            //Oculta las campos referencia y usuario
            var Tipo= eval(document.all.clTipoDeficienciaVTR.value);
            document.all.D5.style.visibility='hidden';
            document.all.D6.style.visibility='hidden';
            switch (Tipo){
                case 1:    //Coordinador
                    document.all.D5.style.visibility='visible';
                    document.all.D6.style.visibility='hidden';
                    break;
                case 2:      //Referencia
                    document.all.D5.style.visibility='hidden';
                    document.all.D6.style.visibility='visible';
                    break;
            }
        </script>
    </body>
</html>
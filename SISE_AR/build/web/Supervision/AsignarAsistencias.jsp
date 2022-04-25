<%@page contentType="text/html; charset=iso-8859-1" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.ResultList,Utilerias.UtileriasBDF" %>
<html>
    <head><title>Asignación de Expedientes a Supervisores</title></head>
    <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    
    <body class="cssBody">
        <%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
        <%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <%
        String StrclUsrApp = "0";
        String StrclPaginaWeb = "0";
        String StrclGrupoCuenta = "0";
        String StrclCuenta = "0";
        String StrFechaIni = "";
        String StrFechaFin = "";
        String StrclAsistencia = "0";
        String StrclSubServicio = "0";
        String StrclEstatus = "";
        String StrclAreaSupervisada = "0";
        String StrPorcentaje = "0";
        String StrUsuariosSeleccionados = "0";
        String StrAsistenciaA = "0";
        String StrAsistenciaT = "0";
        String StrUsuarios = "0";

        boolean blnRegistro = true;
        int asignar=0;

        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }

        if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {%>
            Fuera de Horario
            <%return;  
        }    

        if (request.getParameter("Porcentaje")!=null){
            StrPorcentaje = request.getParameter("Porcentaje").toString();
            if (StrPorcentaje.compareToIgnoreCase("")==0){
                StrPorcentaje = "0";
            }
        }
        
        System.out.println("StrclGrupoCuenta antes del get  "+StrclGrupoCuenta);
        
        if (request.getParameter("clGrupoCuenta")!= ""){
            StrclGrupoCuenta = request.getParameter("clGrupoCuenta").toString();
            System.out.println("StrclGrupoCuenta entre al get despues de tomar valior get  "+StrclGrupoCuenta);
        }

        if (request.getParameter("clCuenta")!= null){
            StrclCuenta = request.getParameter("clCuenta").toString();
            System.out.println("StrclCuenta: "+StrclCuenta);
        }

        if (request.getParameter("FechaIni")!= ""){
            StrFechaIni = request.getParameter("FechaIni").toString();
            System.out.println("StrFechaIni: "+StrFechaIni);
        }

        if (request.getParameter("FechaFin")!= ""){
            StrFechaFin = request.getParameter("FechaFin").toString();
            System.out.println("StrFechaFin: "+StrFechaFin);
        }

        if (request.getParameter("clAsistencia")!= ""){
            StrclAsistencia = request.getParameter("clAsistencia").toString();
            System.out.println("StrclAsistencia: "+StrclAsistencia);
        }

        if (request.getParameter("clSubServicio")!= ""){
            StrclSubServicio = request.getParameter("clSubServicio").toString();
            System.out.println("StrclSubServicio: "+StrclSubServicio);
        }

        if (request.getParameter("clEstatus")!= ""){
            StrclEstatus = request.getParameter("clEstatus").toString();
            System.out.println("StrclEstatus: "+StrclEstatus);
        }

        if (request.getParameter("clAreaSupervisada")!= ""){
            StrclAreaSupervisada = request.getParameter("clAreaSupervisada").toString();
            System.out.println("StrclAreaSupervisada: "+StrclAreaSupervisada);
        }

        if (request.getParameter("UsuariosSeleccionados")!= ""){
            StrUsuariosSeleccionados = request.getParameter("UsuariosSeleccionados").toString();
            System.out.println("StrUsuariosSeleccionados: "+StrUsuariosSeleccionados);
        }

        if (request.getParameter("Porcentaje")!= ""){
            StrPorcentaje = request.getParameter("Porcentaje").toString();
            System.out.println("StrPorcentaje: "+StrPorcentaje);
        }

        if (request.getParameter("Control").compareToIgnoreCase("0")==0){// Asignar Asistencias
            if (request.getParameter("Porcentaje")!=null){
                if (request.getParameter("Porcentaje").toString().compareToIgnoreCase("")==0){%>
                    <p class='cssTitDet'>Debe informar: Porcentaje </p>
                    <%return;
                }
            }
        
            if (request.getParameter("clAreaSupervisada")!=null){
                if (request.getParameter("clAreaSupervisada").toString().compareToIgnoreCase("")==0){%>
                    <p class='cssTitDet'>Debe informar: Area a Supervisar </p>
                    <%return;
                }
            }else{%>
                <p class='cssTitDet'>Debe informar: Area a Supervisar </p>
                <%return;
            }

            if (request.getParameter("UsuariosSeleccionados")!=null){
                if (request.getParameter("UsuariosSeleccionados").toString().compareToIgnoreCase("")==0){%>
                    <p class='cssTitDet'>Debe informar: Usuarios a Asignar</p>
                    <%return;
                }
            }


            ResultList rslAsigna = new ResultList();
            rslAsigna.rsSQL("st_SCSAsignacion " + StrclGrupoCuenta + "," + StrclCuenta + ",'" + StrFechaIni + "','" + StrFechaFin + "','" + StrclAsistencia + "','" + StrclSubServicio + "','" + StrclEstatus + "','" + StrclAreaSupervisada + "','" + StrPorcentaje + "','" + StrUsuariosSeleccionados + "'," + StrclUsrApp);
        
        %>
        <p class='cssTitDet'>Asignación Procesada Correctamente</p>    
        <%                       
        System.out.println("   --- AsignarExpedientes.jsp/ Asignacion Procesada: ");
        //ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        
        if (rslAsigna.next()){
            System.out.println(rslAsigna.getString("AsistneciasA")+"Asistencias Asignadas");
            
            StrAsistenciaA = rslAsigna.getString("AsistneciasA");
            StrAsistenciaT = rslAsigna.getString("AsistneciasT");
            StrUsuarios = rslAsigna.getString("Usuarios");


        

        %>
        
        <table width="200" align="center">
            <tr class="TTable">
                <td align="center">
                    Total De Asistencias
                </td>
            </tr>
            <tr class="R1Table">
                <td align="center">
                    <%=StrAsistenciaT%>    
                </td>
            </tr>
            <tr class="TTable">
                <td align="center">
                    Total De Asistencias Asignadas    
                </td>
                
            </tr>
            <tr class="R2Table">
                <td align="center">
                    <%=StrAsistenciaA%>     
                </td>
            </tr>
            <tr class="TTable">
                <td align="center">
                    Supervisores
                </td>
            </tr>
            <tr class="R1Table">
                <td align="center">
                    <%=StrUsuarios%>    
                </td>
            </tr>
        </table>
        <%
        
        if (asignar==1){ %>
            <script>
                    parent.Selecccion.document.all.Asig.disabled=false;
            </script>
        <%}else{%>
            <script>
                    parent.Selecccion.document.all.Asig.disabled=true;
            </script>
        <%
        }

                    rslAsigna.close();
                    rslAsigna = null; 
        }
        } else{
            //vista previa%>
            <b><font face="arial" SIZE=2 COLOR=#423A9E><b >Criterios de Selección</b></font></b>
        
        <p class='cssTitDet'>Vista Previa</p>
        <% 
        StringBuffer StrSql = new StringBuffer();
        StrSql.append("st_SCSVistaPrevia ").append(StrclGrupoCuenta);
        StrSql.append(",").append(StrclCuenta);
        StrSql.append(",'").append(StrFechaIni);
        StrSql.append("','").append(StrFechaFin);
        StrSql.append("',").append(StrclAsistencia);
        StrSql.append(",").append(StrclSubServicio);
        StrSql.append(",'").append(StrclEstatus);
        StrSql.append("',").append(StrclAreaSupervisada);
        StrSql.append(",").append(StrPorcentaje);
        
        //StringBuffer strSalida = new StringBuffer();
        
        System.out.println("   --- AsignarExpedientes.jsp/ Vista Previa: "+StrSql.toString());
        
        ResultSet rs = UtileriasBDF.rsSQLNP(StrSql.toString());
        
        StrSql.delete(0,StrSql.length());
        StrSql=null;
        
        if (!rs.wasNull()){ %>
        <div style='position:absolute; z-index:20; left:10px; top:80px;'>
            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr class="TTable">
                    <td  width="25%" >Grupo de Cuenta</td>
                    <td  width="25%">Cuenta</td>
                    <td  width="25%">Subservicio</td>
                    <td  width="25%">Servicios</td>
                </tr>
                <%
                while(rs.next()){
                    // Checa que si el registro es par o non
                    if (blnRegistro){
                %>
                <tr class="R1Table">
                <%
                blnRegistro = false;
                    } else {
                %>
                <tr class="R2Table">
                    <%
                    blnRegistro = true;
                    }
                    %>                
                    <td width="25%"><%=rs.getString(1)%></td>
                    <td width="25%"><%=rs.getString(2)%></td>
                    <td width="25%"><%=rs.getString(3)%></td>
                    <td width="25%"><%=rs.getString(4)%></td>
                </tr>
                <% 
                asignar=1;
                }
                %>
            </TABLE>
        </DIV>
        <% if (asignar==1){ %>
        <script>
            parent.Selecccion.document.all.Asig.disabled=false;
        </script>
        <% }else{ %>
        <script>
            parent.Selecccion.document.all.Asig.disabled=true;
        </script>
        <%
        }
        }
         rs.close();
        }
        StrclUsrApp = null;
        StrclPaginaWeb = null;
        StrclGrupoCuenta = null;
        StrclCuenta = null;
        StrFechaIni = null;
        StrFechaFin = null;
        StrclAsistencia = null;
        StrclSubServicio = null;
        StrclEstatus = null;
        StrclAreaSupervisada = null;
        StrPorcentaje = null;
        StrUsuariosSeleccionados = null;
        StrAsistenciaA = null;
        StrAsistenciaT = null;
        StrUsuarios = null;
        %>
    </body>
</html>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<script src='../Utilerias/Util.js'></script>
<%
    String StrclProveedor="0";
    String StrclAreaOperativa="0";
    String StrclCentroAtencion="0";

    if (request.getParameter("clProveedor")!= null){
        StrclProveedor = request.getParameter("clProveedor").toString(); 
     } 

    StringBuffer strSQL = new StringBuffer();

    strSQL.append(" Select P.NombreOpe, P.NombreRZ, ");
    strSQL.append(" P.Titular, P.clAreaOperativa, coalesce(cast(P.Observaciones as varchar(8000)),'') 'Observaciones', ");
    strSQL.append(" E.dsEspecialidad, SE.dsSubEspecialidad ");
    strSQL.append(" from cProveedor P ");
    strSQL.append(" left join cEspecialidad E on (E.clEspecialidad=P.clEspecialidad)");
    strSQL.append(" left join cSubEspecialidad SE on (SE.clSubEspecialidad=P.clSubEspecialidad and SE.clEspecialidad=P.clEspecialidad)");
    strSQL.append(" where P.clProveedor = ").append(StrclProveedor);

    ResultSet rs = UtileriasBDF.rsSQLNP(strSQL.toString());
    strSQL.delete(0,strSQL.length());
    
    if (rs.next()){
        
        StrclAreaOperativa = rs.getString("clAreaOperativa");
        %>
        <center>
        <table border=1 class='FTable'>
        <tr><td class='cssTitDet' colspan="2">Nombre del Proveedor : </td><td colspan="2"><%=rs.getString("NombreOpe")%> </td></t>
        <tr><td class='TTable'>Nombre Razon Social : </td><td><%=rs.getString("NombreRZ")%> </td>
            <td class='TTable'>Titular : </td><td><%=rs.getString("NombreOpe")%> </td></tr>
        <%
        if(StrclAreaOperativa.equalsIgnoreCase("8")){%>
        <tr><td class='Blanco'>Especialidad : </td><td><%=rs.getString("dsEspecialidad")%></td><td class='Blanco'>SubEspecialidad : </td><td><%=rs.getString("dsSubEspecialidad")%></td></tr>
        <%}else{}
        
        
        if(StrclAreaOperativa.equalsIgnoreCase("5")){
    strSQL.append(" Select P.Nombre, P.clPersonalxProv ");
    strSQL.append(" from PersonalxProv P ");
    strSQL.append(" where P.clProveedor = ").append(StrclProveedor);
    
    ResultSet rsPersonal = UtileriasBDF.rsSQLNP(strSQL.toString());
    strSQL.delete(0,strSQL.length());
        while (rsPersonal.next()){
        %><tr><td class='TitResumen'>Nombre del Personal</td>
               <td><%=rsPersonal.getString("Nombre")%></td>
               <td colspan="2">
        <%
        strSQL.append(" Select TC.dsTipoContacto, CxP.Contacto ");
        strSQL.append(" from ContactoxPersonal CxP ");
        strSQL.append(" inner join cTipoContacto TC on (CxP.clTipoContacto = TC.clTipoContacto) ");
        strSQL.append(" where CxP.clPersonalxProv = ").append(rsPersonal.getString("clPersonalxProv"));
            
            ResultSet rsContactos = UtileriasBDF.rsSQLNP(strSQL.toString());
            strSQL.delete(0,strSQL.length());
            while (rsContactos.next()){
                %><table class='FTable'><tr><td><%=rsContactos.getString("dsTipoContacto")%></td><td><%=rsContactos.getString("Contacto")%></td></tr></table>
                <%
            } %>
               </td>
        </tr>
        <%}
            
            }else{
    strSQL.append(" select CA.clCentroAtencion,TC.dsTipoCentroAtencion,CA.NmbCentroAtecion,coalesce(CA.PuestoContacto,'') PuestoContacto,coalesce(CA.Contacto,'') Contacto,");
    strSQL.append(" coalesce(EF.dsEntFed,'') dsEntFed,coalesce(MD.dsMunDel,'') dsMunDel");
    strSQL.append(" from CentroAtencion CA ");
    strSQL.append(" inner join cTipoCentroAtencion TC on (TC.clTipoCentroAtencion=CA.clTipoCentroAtencion)");
    strSQL.append(" left join cEntFed EF on (EF.CodEnt=CA.CodEnt)");
    strSQL.append(" left join cMunDel MD on (MD.CodMD=CA.CodMD and MD.CodEnt=CA.CodEnt)");
    strSQL.append(" where CA.clProveedor= ").append(StrclProveedor);
    
    ResultSet rsCA = UtileriasBDF.rsSQLNP(strSQL.toString());
    strSQL.delete(0,strSQL.length());
        while(rsCA.next()){
            StrclCentroAtencion = rsCA.getString("clCentroAtencion");
        %>                    
        
            
            <tr><td class='cssAzul' ><input class='cBtn' type='button' value='Asignar' onClick='window.opener.fnRelocate("../Operacion/AsignaProveedor.jsp?Proveedor=<%=StrclProveedor%>&Centro=<%=StrclCentroAtencion%>");window.close();'></input></td><td class='cssAzul' colspan="3"><%=rsCA.getString("dsTipoCentroAtencion")%> : <%=rsCA.getString("NmbCentroAtecion")%></td></tr>
            <tr><td class='TitResumen'><%=rsCA.getString("PuestoContacto")%></td ><td><%=rsCA.getString("Contacto")%></td><td>Entidad:<%=rsCA.getString("dsEntFed")%></td><td>Municipio:<%=rsCA.getString("dsMunDel")%></td></tr>           
            
            
        <%
        if(StrclAreaOperativa.equalsIgnoreCase("9")){
                
    strSQL.append(" select CS.dsServicioMedico from ServicioMedxCentroAtencion SM");
    strSQL.append(" inner join cserviciomedico CS on (CS.clServicioMedico=SM.clServicioMedico)");
    strSQL.append(" where SM.clCentroAtencion=").append(StrclCentroAtencion);
    
    ResultSet rsSM = UtileriasBDF.rsSQLNP(strSQL.toString());
    strSQL.delete(0,strSQL.length());
    %><tr><td class='Blanco'>Servicio Medico : </td><td colspan="3">
    <%
                while(rsSM.next()){
        %>
            <%=rsSM.getString("dsServicioMedico")%><br>
            
        <%
                }//Fin de While rsSM
    %>
    </td></tr>
    <%
        rsSM.close();
        rsSM=null;
           }//Fin IF AreaOperativa 9
            }//Fin de While rsCA
    rsCA.close();
    rsCA=null;
        %>
        </table>
        </center>
    <%
        }
    }
    rs.close();
    rs=null;
%>
</body>
</html>

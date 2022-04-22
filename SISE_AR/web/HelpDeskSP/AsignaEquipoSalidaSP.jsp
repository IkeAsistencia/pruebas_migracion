<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Actualiza Fecha Proveedor</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj" />
        <script src='../../Utilerias/Util.js' ></script>
        <%
        String StrclUsrApp="0";
        String StrclPerifericoSP="0";
        
        String StrError="0";
        String StrclEquipoSalidaSP="0";
        ResultSet   rs = null;
        
        if (session.getAttribute("clUsrAppSP")!= null)  {
            StrclUsrApp = session.getAttribute("clUsrAppSP").toString();         }
        if (session.getAttribute("clPerifericoSP")!= null){
            StrclPerifericoSP = session.getAttribute("clPerifericoSP").toString();        }
        if(request.getParameter("clPerifericoSP")!= null){
            StrclPerifericoSP = request.getParameter("clPerifericoSP").toString().trim();       }
        
        if ( request.getParameter("clEquipoSalidaSP")!= null )  {
            StrclEquipoSalidaSP = request.getParameter("clEquipoSalidaSP").toString();
            session.setAttribute("clEquipoSalidaSP",StrclEquipoSalidaSP);
        } else {
            if ( session.getAttribute("clEquipoSalidaSP")!= null )  {
                StrclEquipoSalidaSP = session.getAttribute("clEquipoSalidaSP").toString();
            }
        }

                //<<<<<<<<<<<<<ASIGNACION>>>>>>>>>>>>>>>>>>>>
                System.out.println("sp_AsignaPerifericoSalidaSP '"+StrclEquipoSalidaSP+"','"+ StrclPerifericoSP+"'");
                
                rs=UtileriasBDF.rsSQLNP("sp_AsignaPerifericoSalidaSP '"+StrclEquipoSalidaSP+"','"+ StrclPerifericoSP+"'");
                if(rs.next()){
                    
                StrError=rs.getString("Error"); }
                if( StrError.equals("0")){
        %>
           
        <script>alert('EQUIPO ASIGNADO CORRECTAMENTE');</script>
        <script>location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../HelpDeskSP/EquipoSalidaSP.jsp?';</script>
        <%
        
     
                
            } else {
        %><script>alert('NO SE ASIGNO EL   EQUIPO');</script>
        <script>location.href='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>../HelpDeskSP/EquipoSalidaSP.jsp?';</script>
        <%
            }   
        
        StrclUsrApp=null;
        StrclPerifericoSP=null;
        StrError=null;
        rs = null;
        %>
        <script>
        top.frames['Contenido'].location.reload();
        </script>
    </body>
</html>
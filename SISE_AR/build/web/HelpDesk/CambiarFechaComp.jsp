<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="com.ike.helpdesk.DAOHelpdesk,com.ike.helpdesk.HDSolicitud,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilMask.js'></script> 
        <%  
        String StrclSolicitud = "0";
        String StrAct = "0";
        String StrFechaNue = "";
        String StrFechaAnt = "";
        String StrclUsrApp = "0";
        String StrJustificacion = "";
        
        if (session.getAttribute("clUsrApp")!= null) {
            StrclUsrApp = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("clSolicitud")!= null) {
            StrclSolicitud= request.getParameter("clSolicitud").toString();
        }
        
        if (request.getParameter("Act")!= null) {
            StrAct= request.getParameter("Act").toString();
        }
        
        if (request.getParameter("FechaNue")!= null) {
            StrFechaNue = request.getParameter("FechaNue").toString();
        }
        
        if (request.getParameter("FechaAnt")!= null) {
            StrFechaAnt = request.getParameter("FechaAnt").toString();
        }
        
        if (request.getParameter("Justificacion")!= null) {
            StrJustificacion = request.getParameter("Justificacion").toString();
        }
        
        DAOHelpdesk daoh = null;
        HDSolicitud  Solicitud = null;
        StringBuffer StrSql = new StringBuffer();
        
        if(StrAct.equalsIgnoreCase("0")){
            
            
            if (StrclSolicitud.compareToIgnoreCase("0")!=0){
                daoh = new DAOHelpdesk();
                Solicitud = daoh.getSolicitud(StrclSolicitud);
            }
            
            if(Solicitud==null){%>
        <div id='Estatus' Name='Estatus' class='VTable' style='position:absolute; z-index:11; left:30px; top:30px;'><p class='Rojo'>No existe la solicitud</p> </div>
        
        <%
        return;
            }
            
            if(Solicitud.getFechaCompromiso().equalsIgnoreCase("")){%>
        <div id='Estatus' Name='Estatus' class='VTable' style='position:absolute; z-index:11; left:30px; top:30px;'><p class='Rojo'>La Solictud no tiene Fecha Compromiso</p> </div>
        <%
        return;
            }
        %>
        
        <form id='Forma' name ='Forma' action='CambiarFechaComp.jsp' method='get'>
            <INPUT id='clSolicitud' name='clSolicitud' type='hidden' value='<%=StrclSolicitud%>'>
            <INPUT id='Act' name='Act' type='hidden' value='1'>
            
            <div style='position:absolute; z-index:14; left:390px; top:77px;'><input type="button" value="Guardar" onClick="fnGuarda();" ></input></div>
            
            <div id='D15' Name='D15' class='VTable' style='position:absolute; z-index:15; left:50px; top:60px;'><p class='FTable'>Fecha Anterior<br>(aaaa/mm/dd)<br><INPUT readOnly class='VTable' label='Fecha Anterior<br>(aaaa/mm/dd)'  onBlur='if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};'  size=20 id='FechaAnt' name='FechaAnt' value='<%=Solicitud.getFechaCompromiso().toString()%>'></INPUT></p></div>
            <div id='D16' Name='D16' class='VTable' style='position:absolute; z-index:16; left:250px; top:60px;'><p class='FTable'>Fecha Nueva<br>(aaaa/mm/dd)<br><INPUT class='VTable' label='Fecha Nueva<br>(aaaa/mm/dd)'  onBlur='if(this.readOnly==false){fnValMask(this,document.all.FechaMsk.value,this.name)};'  size=20 id='FechaNue' name='FechaNue' value=''></INPUT></p></div>
            <div id='D17' Name='D17' class='VTable' style='position:absolute; z-index:17; left:50px; top:110px;'><p class='FTable'>Justificacion<br><TEXTAREA class='VTable' label='Justificacion'  rows=5 cols=75  id='Justificacion' name='Justificacion'></TEXTAREA></p></div>
            <div class='cssBGDetSw' style='background-color:#052145; position:absolute; z-index:1; left:30px; top:50px; width:470px; height:170px;'><p class='cssTitDet'></p></div><div class='cssBGDet' style='position:absolute; z-index:2; left:20px; top:40px; width:470px; height:170px;'><p class='cssTitDet'>Fecha de Compromiso</p></div>
            <%
            }else{
            
            
            StrSql.append("sp_CambiaFechaComp '").append(StrclSolicitud.toString()).append("','")
            .append(StrFechaNue.toString()).append("','").append(StrclUsrApp.toString())
            .append("','").append(StrFechaAnt.toString()).append("','").append(StrJustificacion.toString()).append("'");
            
            UtileriasBDF.ejecutaSQLNP(StrSql.toString());
            StrSql.delete(0,StrSql.length());
            %>
            <script>window.opener.fnRelocate('../HelpDesk/DetalleSolicitud.jsp?');window.close();</script>
            <%}
            
            StrclSolicitud =null;
            StrAct = null;
            StrFechaNue = null;
            StrFechaAnt = null;
            StrclUsrApp = null;
            StrJustificacion = null;       
            
            daoh=null;
            Solicitud=null;
            
            StrSql=null;
            %>
            <input name='FechaMsk' id='FechaMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
        </form>
        <script>
    function fnGuarda(){
        if (document.all.FechaNue.value=="" || document.all.Justificacion.value==""){
                alert("Debe informar: Nueva Fecha de Compromiso y Justificacion del Cambio de Fecha");
        }else{
        this.disabled=true;document.all.Forma.submit();
        }
    }
        </script>
    </body>
</html>


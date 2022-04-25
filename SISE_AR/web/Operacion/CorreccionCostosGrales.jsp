<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>Costos Generales</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src='../Utilerias/Util.js' ></script>
<script src='../Utilerias/UtilMask.js' ></script>
<script src='../Utilerias/UtilCostos.js' ></script>
<%  
    String StrclExpediente = "0";   
    StringBuffer StrSql = new StringBuffer();
    String StrclUsrApp="0";
    String StrclPaginaWeb="0";
    String StrclCosto="0";
    String StrclServicio="0"; 
    String StrclSubServicio="0";
    String strTotal="";
    String strMontoL = "0";
    if (session.getAttribute("clUsrApp")!= null) {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
    }  
    if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
       %>Fuera de Horario<%
       return;   
    }    
    if (request.getParameter("clExpediente")!= null) {
        StrclExpediente= request.getParameter("clExpediente").toString(); 
    }  
    if (session.getAttribute("clServicio")!= null) {
       StrclServicio = session.getAttribute("clServicio").toString(); 
    }   
    if (session.getAttribute("clSubServicio")!= null) {
        StrclSubServicio = session.getAttribute("clSubServicio").toString(); 
    }       
    if (request.getParameter("clCosto")!= null) {
        StrclCosto= request.getParameter("clCosto").toString(); 
    }  
    
    StrSql.append(" select clExpediente, SUM(CostoSEA) 'CostoSEAT'");
    StrSql.append(" FROM Costos");
    StrSql.append(" Where clExpediente =").append(StrclExpediente).append("group by clExpediente");
    
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    if (rs.next()) { 
        strTotal = rs.getString("CostoSEAT");
            if (strTotal ==null){
                strTotal = "";
            } 
    }
    rs.close();
    rs=null;
    
    StrSql.delete(0,StrSql.length());
    StrSql.append(" select SxC.LimiteMonto as LimiteMonto");
    StrSql.append(" from expediente E");
    StrSql.append(" inner join ccobertura COB on (E.clCuenta = COB.clCuenta)");
    StrSql.append(" inner join SubServicioxCobertura SxC on (COB.clCobertura = SxC.clCobertura and SxC.clServicio=").append(StrclServicio).append("and SxC.clSubServicio=").append(StrclSubServicio).append(")");
    StrSql.append(" where clExpediente =").append(StrclExpediente);
    
    rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    if (rs.next()) { 
        strMontoL = rs.getString("LimiteMonto");
            if (strMontoL ==null){
                strMontoL = "";
            } 
    }
    
    StrSql.delete(0,StrSql.length());
    StrSql.append("Select C.clExpediente as clExpediente, C.clCosto, P.clProveedor, p.NombreOpe 'dsProveedor',");
    StrSql.append(" COALESCE(CC.dsConcepto,'') 'dsConcepto',c.clConcepto, c.CostoSEA, coalesce(C.CostoNU,0) CostoNU, clPagoProveedor ");
    StrSql.append(" FROM Costos C");
    StrSql.append(" INNER JOIN cProveedor P on(P.clProveedor=C.clProveedor) ");
    StrSql.append(" LEFT JOIN cConceptoCosto CC on(CC.clConcepto=C.clConcepto) ");
    StrSql.append(" Where clCosto =").append(StrclCosto);
    
    rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        
    StrclPaginaWeb = "436";       
    MyUtil.InicializaParametrosC(436,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
    session.setAttribute("clPaginaWebP",StrclPaginaWeb); 
   %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccionCorrigeCto","")%>
    <!--   <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>CorreccionCostosGrales.jsp?clExpediente=StrclExpediente +>   -->
    <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>CorreccionCostosGrales.jsp?'>  
    <%
    if (rs.next()) { %>
        <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=rs.getString("clExpediente")%>'>
        <INPUT id='clCosto' name='clCosto' type='hidden' value='<%=rs.getString("clCosto")%>'>
        <INPUT id='clPagoProveedor' name='clPagoProveedor' type='hidden' value='<%=rs.getString("clPagoProveedor")%>'>
        <INPUT id='Nomina' name='Nomina' type='hidden' value='0'>
        <%=MyUtil.ObjComboC("Proveedor", "clProveedor",rs.getString("dsProveedor"),false,false,30,70,"","sp_LlenaComboProvxExp " + StrclExpediente,"","",50,false,false)%>
        <%=MyUtil.ObjInput("Concepto","ConceptoCat",rs.getString("dsConcepto"),false,false,30,110,"",false,false,50)%>

        <!--%=MyUtil.ObjInput("Concepto","Concepto",rs.getString("Concepto"),true,true,30,150,"",true,true,50)%-->
        <%=MyUtil.ObjComboC("Concepto", "cboConcepto", rs.getString("dsConcepto"), true, true, 30, 150, "", "sp_LlenaConceptos " + StrclExpediente + "," + StrclCosto, "", "", 50, true, true)%>
        <input type="hidden" name="clConcepto" id="clConcepto" value="<%=rs.getString("clConcepto")%>">
        <input type="hidden" name="Concepto" id="Concepto" value="<%=rs.getString("dsConcepto")%>">
        <%=MyUtil.ObjInput("Costo SEA","CostoSEA",rs.getString("CostoSEA"),true,true,30,190,"",true,true,7)%>
        <%=MyUtil.ObjInput("Costo NU","CostoNU",rs.getString("CostoNU"),false,true,100,190,"",false,false,7)%>
        <%=MyUtil.ObjInput("Costo SEA TOTAL","CostoSEAT",strTotal,false,false,170,190,strTotal,false,false,7)%>
        <%=MyUtil.ObjInput("Limite de cobertura","LimiteMonto",strMontoL,false,false,280,190,strMontoL,false,false,7)%>
        <%=MyUtil.ObjInput("Comentarios","Comentarios","",true,true,30,230,"",false,false,80)%>
        <div class='VTable' style='position:absolute; z-index:25; left:260px; top:80px;'>
        </div>
        <%=MyUtil.DoBlock("Costo",180,0)%><%
    } 
    else { 
    } 
    %><%=MyUtil.GeneraScripts()%><%
    rs.close();
    rs=null;
 %>
 
 <script>
 /*function fncomparecosto(){
  var sum;
  sum = document.all.CostoSEA.value + document.all.CostoSEAT.value;
    if (sum > document.all.LimiteMonto.value){
        msgVal = msgVal + "El Costo SEA Total a revasado el Limite de la cobertura";
        document.all.CostoSEA.value = "";
    }
 }*/
  $('#cboConceptoC').change(function(){
    $('#clConcepto').val(  $('#cboConceptoC').find('option:selected').val() );
    $('#Concepto').val( $('#cboConceptoC').find('option:selected').text() );
  })
    
 </script>
</body>
</html>
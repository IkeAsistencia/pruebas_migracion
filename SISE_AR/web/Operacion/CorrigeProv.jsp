<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="page" class="Utilerias.UtileriasObj"/>

<script src='../Utilerias/Util.js'></script>
<script src='../Utilerias/UtilDireccion.js'></script>
<script src='../Utilerias/UtilMask.js'></script>
<script>
top.document.all.rightPO.rows="70,*";
</script>
<%  

        
        
        
    	  String StrclExpediente = "0"; 
    	  String strclUsr = "";
        String strclProveedor="0";
        String StrclPaginaWeb="0";
        String strNombreO = "";
      	if (session.getAttribute("clUsrApp")!= null)
      	{
       		strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  

        if (request.getParameter("clExpediente")!= null)
        {
            StrclExpediente= request.getParameter("clExpediente").toString(); 
        }  
        if (request.getParameter("clProveedor")!= null)
        {
            strclProveedor= request.getParameter("clProveedor").toString(); 
        }  
        if (request.getParameter("NombreO")!= null)
        {
            strNombreO= request.getParameter("NombreO").toString(); 
        }  
        
        
        //session.setAttribute("clExpediente",StrclExpediente);
       StrclPaginaWeb = "445";
	      session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <SCRIPT>fnOpenLinks()</script>
        <%        
        MyUtil.InicializaParametrosC( 445,Integer.parseInt(strclUsr)); 
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.CorrigeProvAct","",";")%>  		        
        <INPUT id='URLBACK' name='URLBACK' type='hidden' value='<%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%>CorrigeProv.jsp?'>
       
      <%=MyUtil.ObjInput("Proveedor Actual", "ProvVtr",strNombreO,true,false,25,100,strNombreO,true,true,50,"")%>        
      <%=MyUtil.DoBlock("Proveedor Actual",250,0)%>
      
            <INPUT id='clUsrApp' name='clUsrApp' type='hidden' value='<%=strclUsr%>'>
            <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
            <INPUT id='clProveedor' name='clProveedor' type='hidden' value='<%=strclProveedor%>'>
           <%=MyUtil.ObjInput("Proveedor Nuevo", "ProvNu","",true,false,25,200,"",true,true,50,"if(this.readOnly==false){fnBuscaProvNue();}")%>
            <INPUT id='clProvNue' name='clProvNue' type='hidden' value=''>
            
          <%
                if (MyUtil.blnAccess[4]==true){
                    %><div class='VTable' style='position:absolute; z-index:25; left:320px; top:215px;'>
                       <IMG SRC='../Imagenes/Lupa.gif' onClick='fnBuscaProvNue();' WIDTH=20 HEIGHT=20></div>
               
               
               <%
               }
            %>
	    
     <%=MyUtil.DoBlock("CAMBIO DE PROVEEDOR",250,30)%>
        
	    <%=MyUtil.GeneraScripts()%>
        
       <script>document.all.ProvNu.readOnly=false;</script>
<script>

function fnBuscaProvNue(){
    if (document.all.ProvNu.value!=''){
             var pstrCadena = "../Utilerias/FiltrosCuentaProv.jsp?strSQL=sp_WebBuscaProv ";
             pstrCadena = pstrCadena + "&dsProvedor= " + document.all.ProvNu.value;
             document.all.clProvNue.value='';
             window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=700,height=500');
         
    }
}

function fnActualizaDatosProv(NombreOpe,clProveedor){
	document.all.ProvNu .value = NombreOpe;			
	document.all.clProvNue.value = clProveedor;
}
</script>
</body>
</html>


<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
<script src='../Utilerias/UtilMask.js'></script>
<script src='../Utilerias/Util.js' ></script>

<%

    	String strclUsr = "";
        String strclContrato = "0";
        String strclCuenta = "0"; 

      
      

      	if (session.getAttribute("clUsrApp")!= null)
      	{
            strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  

        if (SeguridadC.verificaHorarioC((Integer.parseInt(strclUsr))) != true) 
        {
            %>Fuera de Horario<% 
            
              return; 
        } 
        
      	if (request.getParameter("clContrato")!= null)
      	{
            strclContrato= request.getParameter("clContrato").toString(); 
       	}  
        session.setAttribute("clContrato",strclContrato);
        
        String strNombreCta = "";

      	if (session.getAttribute("NombreCta")!= null)
      	{
            strNombreCta = session.getAttribute("NombreCta").toString(); 
        }  
      	if (session.getAttribute("clCuenta")!= null)
      	{
            strclCuenta = session.getAttribute("clCuenta").toString(); 
        }  
 
        StringBuffer StrSql = new StringBuffer();
       	StrSql.append("select coalesce(CxC.clContrato,'') clContrato,coalesce(CxC.ContratoEspecial,'') ContratoEspecial, coalesce(CxC.PrefijoContrato,'') PrefijoContrato,ES.PrefijoContrato PC, " );
                    StrSql.append(" coalesce(CxC.ContratoInterno,'') ContratoInterno, coalesce(CxC.IncisoAutomatico,'') IncisoAutomatico, " );
                    StrSql.append(" coalesce(convert(varchar(20),CxC.FechaAlta,120),'') FechaAlta, " );
                    StrSql.append(" coalesce(CxC.Activo,0) Activo, " );
                    StrSql.append(" coalesce(convert(varchar(20),CxC.FechaBaja,120),'') FechaBaja, " );
                    StrSql.append(" coalesce(convert(varchar(10),CxC.FechaIni,120),'') FechaIni, " ); 
                    StrSql.append(" coalesce(convert(varchar(10),CxC.FechaFin,120),'') FechaFin " );                     
                    StrSql.append(" from cCuenta C " );
                    StrSql.append(" inner join cEmpresaSEA ES on (ES.clEmpresaSEA = C.clEmpresaSEA) " );
                    StrSql.append(" left join ContratoxCuenta CxC on (CxC.clCuenta = C.clCuenta and clContrato = ").append(strclContrato).append(") ");
                    StrSql.append(" Where C.clCuenta = ").append(strclCuenta);
      
       	String StrclPaginaWeb = "173";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);

        %><script>fnOpenLinks(window.parent.frames.InfoRelacionada.height) </script><%
        
       	MyUtil.InicializaParametrosC( 173,Integer.parseInt(strclUsr)); 
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAltaContrato","","")%> 		        
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleContratoxCta.jsp?'>"%>
        <INPUT id='clContrato' name='clContrato' type='hidden' value='<%=strclContrato%>'>
        <INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=strclCuenta%>'>         
	<%=MyUtil.ObjInput("Nombre de la Cuenta","Nombre",strNombreCta,false,false,30,80,strNombreCta,false,false,60)%><%
        
        if (rs.next()) { %>
          
            <%=MyUtil.ObjInput("Contrato (Numero)","clContratoVTR",rs.getString("clContrato"),false,false,390,80,"",false,false,20)%>
            <%=MyUtil.ObjInput("Contrato Especial","ContratoEspecial",rs.getString("ContratoEspecial"),true,true,30,120,"",true,true,15)%>
            <%=MyUtil.ObjInput("Prefijo Contrato","PrefijoContrato",rs.getString("PrefijoContrato"),false,false,170,120,rs.getString("PC"),true,true,2)%>            
            <%=MyUtil.ObjInput("Contrato Interno","ContratoInterno",rs.getString("ContratoInterno"),false,false,300,120,"",false,false,10)%>   
            <%=MyUtil.ObjChkBox("Contrato Automático","IncisoAutomatico",rs.getString("IncisoAutomatico"),true,true,450,120,"0","SI","NO","fnalert()")%>            
            <%=MyUtil.ObjInput("Fecha Alta<br>(AAAA/MM/DD HH:MM)","FechaAlta",rs.getString("FechaAlta"),false,false,30,160,"",false,false,19)%>                        
            <%=MyUtil.ObjChkBox("Activo","Activo",rs.getString("Activo"),false,true,165,170,"1","SI","NO","")%>            
            <%=MyUtil.ObjInput("Fecha Baja<br>(AAAA/MM/DD HH:MM)","FechaBaja",rs.getString("FechaBaja"),false,false,250,160,"",false,false,19)%>                        
            <%=MyUtil.ObjInput("Fecha Inicio<br>(AAAA/MM/DD)","FechaIni",rs.getString("FechaIni"),true,true,390,160,"",true,true,15,"if(this.readOnly==false){fnValMask(this,document.all.FechaIniMsk.value,this.name)}")%>                        
            <%=MyUtil.ObjInput("Fecha Fin<br>(AAAA/MM/DD)","FechaFin",rs.getString("FechaFin"),true,true,500,160,"",true,true,15,"if(this.readOnly==false){fnValMask(this,document.all.FechaFinMsk.value,this.name)}")%><%                                   
        }  %>
        <%=MyUtil.DoBlock("Detalle del Contrato",140,0)%>                
	<%=MyUtil.GeneraScripts()%><%  		
        rs.close();
        rs=null;
        
        strNombreCta = null;
    	strclUsr = null;
        strclContrato = null;
        strclCuenta = null;
        StrSql = null;
       	StrclPaginaWeb = null;

%>
<input name='FechaIniMsk' id='FechaIniMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<input name='FechaFinMsk' id='FechaFinMsk' type='hidden' value='VN09VN09VN09VN09F-/-VN09VN09F-/-VN09VN09'>
<script>
function fnalert(){
  if(document.all.IncisoAutomatico.value==1){
  document.all.ContratoEspecial.value=0;
  document.all.ContratoEspecial.disabled=true;
    
  }
else{
  document.all.ContratoEspecial.disabled=false;
  document.all.ContratoEspecial.value="";
  
  }
}

/*function fnConEspecial(){
  if(document.all.ContratoEspecial.value==""){
                 msgVal=msgVal + " Contrato Especial ";
              }
}*/
</script>
</body>
</html>

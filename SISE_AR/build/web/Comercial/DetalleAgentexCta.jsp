<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
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
    	String StrclAgentexCta = "0";
    	String StrclCuenta = "0";
    	String strclUsr = "";
      
      

      	if (session.getAttribute("clUsrApp")!= null)
      	{
            strclUsr = session.getAttribute("clUsrApp").toString(); 
        }  
        
      	if (session.getAttribute("clCuenta")!= null)
      	{
            StrclCuenta = session.getAttribute("clCuenta").toString(); 
        }  

      	if (request.getParameter("clAgentexCta")!= null)
      	{
            StrclAgentexCta = request.getParameter("clAgentexCta").toString(); 
       	}  
        
        StringBuffer StrSql = new StringBuffer();
       	StrSql.append("select * from cAgentexCta ");
                    StrSql.append(" Where clAgentexCta = ").append(StrclAgentexCta);
       
       	String StrclPaginaWeb = "256";
	session.setAttribute("clPaginaWebP",StrclPaginaWeb);
          
       	MyUtil.InicializaParametrosC( 256,Integer.parseInt(strclUsr)); 
	%><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%><%  		        
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString()); 
        StrSql.delete(0,StrSql.length());%>

        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleAgentexCta.jsp?'>"%><%
        if (rs.next()) { %> 
		<INPUT id='clAgentexCta' name='clAgentexCta' type='hidden' value='<%=StrclAgentexCta%>'>
		<INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
		<%=MyUtil.ObjInput("Agente","Agente",rs.getString("Agente"),true,true,25,80,"",true,true,15,"if(this.readOnly==false){fnValMask(this,document.all.AgenteMsk.value,this.name)}")%><%
        }
	else{ %>
		<INPUT id='clAgentexCta' name='clAgentexCta' type='hidden' value='<%=StrclAgentexCta%>'>
		<INPUT id='clCuenta' name='clCuenta' type='hidden' value='<%=StrclCuenta%>'>
		<%=MyUtil.ObjInput("Agente","Agente","",true,true,25,80,"",true,true,15,"if(this.readOnly==false){fnValMask(this,document.all.AgenteMsk.value,this.name)}")%><%
	} %>			 
        <%=MyUtil.DoBlock("Detalle de Agente",25,0)%>
	<%=MyUtil.GeneraScripts()%><% 		
        rs.close();
        rs=null;
        
    	StrclAgentexCta = null;
    	StrclCuenta = null;
    	strclUsr = null;
        StrSql = null;
        StrclPaginaWeb = null;
%>
<input name='AgenteMsk' id='AgenteMsk' type='hidden' value='VN09VN09VN09VN09'>
</body>
</html>

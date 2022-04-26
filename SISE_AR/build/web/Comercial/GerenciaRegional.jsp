<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
<head><title>JSP Page</title>
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>


<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../Utilerias/Util.js' ></script>


<%  

    String StrclCampoExtra = "0";
    String StrclUsrApp="0";
    
    

    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  
    
    if (request.getParameter("clCampoExtra") != null)
    {
//      out.println("SI TRAIGO PARAMETRO CAMPO EXTRA");
      StrclCampoExtra = request.getParameter("clCampoExtra");
 //     out.println(StrclCampoExtra);      
    }    
 StringBuffer StrSql1 = new StringBuffer();
StrSql1.append("select E.clCampoExtra, E.Nombre, E.Titulo, E.ValorDefault, E.clTipoObjeto, Obj.TipoObjeto, E.clTipoCampo, Cam.TipoCampo, E.Longitud, E.tSize, E.EditAlta, E.EditCambio, E.ReqAlta, E.ReqCambio, E.EtiqChecked, E.EtiqUnChecked, E.SentenciaSQL ");
StrSql1.append(" From cCampoExtra E Inner Join cTipoObjeto Obj ON (Obj.clTipoObjeto=E.clTipoObjeto) Inner Join cTipoCampo Cam ON(Cam.clTipoCampo=E.clTipoCampo) ");
StrSql1.append(" Where clCampoExtra=").append(StrclCampoExtra);
ResultSet rs = UtileriasBDF.rsSQLNP(StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
       String StrclPaginaWeb = "13";
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       MyUtil.InicializaParametrosC( 13,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       %>
       <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='http://localhost:8080/SIAIKE/Comercial/CamposExtra.jsp?'>"%>
       <%
       if (rs.next()) {
           %>
           <INPUT id='clCampoExtra' name='clCampoExtra' type='hidden' value='<%=StrclCampoExtra%>'><br><br><br><br>
            <%=MyUtil.ObjInput("Nombre de Campo","Nombre",rs.getString("Nombre"),true,true,20,100,"",true,true,20)%>
            <%=MyUtil.ObjComboC("Tipo de Objeto","clTipoObjeto",rs.getString("TipoObjeto"),true,true,180,100,"","Select * From cTipoObjeto Order by TipoObjeto","","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Campo","clTipoCampo",rs.getString("TipoCampo"),true,true,360,100,rs.getString("TipoCampo"),"Select * From cTipoCampo Order by TipoCampo","","",60,true,true)%>
            <%=MyUtil.ObjInput("Longitud","Longitud",rs.getString("Longitud"),true,true,20,150,"",true,true,10)%>
            <%=MyUtil.ObjInput("SIZE (en Pantalla)","tSize",rs.getString("tSize"),true,true,180,150,"",true,true,10)%>
            <%=MyUtil.ObjInput("Etiqueta Checked","EtiqChecked",rs.getString("EtiqChecked"),true,true,300,150,"",false,false,20)%>
            <%=MyUtil.ObjInput("Etiqueta UnChecked","EtiqUnChecked",rs.getString("EtiqUnChecked"),true,true,470,150,"",false,false,20)%>
            <%=MyUtil.ObjInput("Título","Titulo",rs.getString("Titulo"),true,true,20,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Valor Default","ValorDefault",rs.getString("ValorDefault"),true,true,180,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Sentencia SQL","SentenciaSQL",rs.getString("SentenciaSQL"),true,true,340,200,"",false,false,42)%>
            <%=MyUtil.ObjChkBox("Editar en Alta","EditAlta",rs.getString("EditAlta"),true,true,20,250,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Editar en Cambio","EditCambio",rs.getString("EditCambio"),true,true,150,250,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Requerido en Alta","ReqAlta",rs.getString("ReqAlta"),true,true,300,250,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Requerido en Cambio","ReqCambio",rs.getString("ReqCambio"),true,true,450,250,"0","SI","NO","")%>
<%            

        }
       else {
  %>
            <%=MyUtil.ObjInput("Nombre de Campo","Nombre","",true,true,20,100,"",true,true,20)%>
            <%=MyUtil.ObjComboC("Tipo de Objeto","clTipoObjeto","",true,true,180,100,"","Select * From cTipoObjeto Order by TipoObjeto","","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Campo","clTipoCampo","",true,true,360,100,"","Select * From cTipoCampo Order by TipoCampo","","",60,true,true)%>
            <%=MyUtil.ObjInput("Longitud","Longitud","",true,true,20,150,"",true,true,10)%>
            <%=MyUtil.ObjInput("SIZE (en Pantalla)","tSize","",true,true,180,150,"",true,true,10)%>
            <%=MyUtil.ObjInput("Etiqueta Checked","EtiqChecked","",true,true,300,150,"",false,false,20)%>
            <%=MyUtil.ObjInput("Etiqueta UnChecked","EtiqUnChecked","",true,true,470,150,"",false,false,20)%>
            <%=MyUtil.ObjInput("Título","Titulo","",true,true,20,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Valor Default","ValorDefault","",true,true,180,200,"",false,false,20)%>
            <%=MyUtil.ObjInput("Sentencia SQL","SentenciaSQL","",true,true,340,200,"",false,false,42)%>
            <%=MyUtil.ObjChkBox("Editar en Alta","EditAlta","",true,true,20,250,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Editar en Cambio","EditCambio","",true,true,150,250,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Requerido en Alta","ReqAlta","",true,true,300,250,"0","SI","NO","")%>
            <%=MyUtil.ObjChkBox("Requerido en Cambio","ReqCambio","",true,true,450,250,"0","SI","NO","")%>
            <%
        }           
            %>
          <%=MyUtil.DoBlock("Detalle de Campo Extra")%> 
          <%=MyUtil.GeneraScripts()%>
 <%         
rs.close();
rs=null;

StrSql1 =null;
StrclUsrApp=null;
StrclCampoExtra= null;
StrclPaginaWeb= null;
%>



</body>
</html>

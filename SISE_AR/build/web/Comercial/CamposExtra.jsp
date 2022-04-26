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

    String StrclUsrApp="0";
    
    
    
    if (session.getAttribute("clUsrApp")!= null)
     {
       StrclUsrApp = session.getAttribute("clUsrApp").toString(); 
     }  

    if (SeguridadC.verificaHorarioC((Integer.parseInt(StrclUsrApp))) != true) 
     {
       %>Fuera de Horario<%
         
         return;
     }    
    String StrclCampoExtra = "0";
    
    if (request.getParameter("clCampoExtra") != null)
    {
//      out.println("SI TRAIGO PARAMETRO CAMPO EXTRA");
      StrclCampoExtra = request.getParameter("clCampoExtra");
    }    
    
      StringBuffer StrSql = new StringBuffer();
      StrSql.append("select E.clCampoExtra, E.Nombre, coalesce(E.Titulo,'') as Titulo, coalesce(E.ValorDefault,'') as ValorDefault, E.clTipoObjeto, Obj.TipoObjeto, E.clTipoCampo, Cam.TipoCampo, E.Longitud, coalesce(E.tSize,'') as tsize, E.EditAlta, E.EditCambio, E.ReqAlta, E.ReqCambio, coalesce(E.EtiqChecked,'') as EtiqChecked, coalesce(E.EtiqUnChecked,'') as EtiqUnChecked, coalesce(E.SentenciaSQL,'') as SentenciaSQL, coalesce(E.ValorRef,'') ValorRef ");
      StrSql.append(" From cCampoExtra E Inner Join cTipoObjeto Obj ON (Obj.clTipoObjeto=E.clTipoObjeto) Inner Join cTipoCampo Cam ON(Cam.clTipoCampo=E.clTipoCampo) ");
      StrSql.append(" Where clCampoExtra=").append(StrclCampoExtra);
      ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
      StrSql.delete(0,StrSql.length());

       String StrclPaginaWeb = "13";
       
       session.setAttribute("clPaginaWebP",StrclPaginaWeb);

       MyUtil.InicializaParametrosC(13,Integer.parseInt(StrclUsrApp));    // se checan permisos de alta,baja,cambio,consulta de esta pagina
       %><%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","")%>      
       <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="CamposExtra.jsp?'>"%><%
       if (rs.next()) {
            // El siguiente campo llave no se mete con MyUtil.ObjInput  %>
            <INPUT id='clCampoExtra' name='clCampoExtra' type='hidden' value='<%=StrclCampoExtra%>'><br><br><br><br>
            <%=MyUtil.ObjInput("Nombre de Campo","Nombre",rs.getString("Nombre"),true,true,20,100,"",true,true,20)%>
            <%=MyUtil.ObjComboC("Tipo de Objeto","clTipoObjeto",rs.getString("TipoObjeto"),true,true,180,100,"","Select * From cTipoObjeto Order by TipoObjeto","","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Campo","clTipoCampo",rs.getString("TipoCampo"),true,true,360,100,rs.getString("TipoCampo"),"Select * From cTipoCampo Order by TipoCampo","","",60,true,true)%>
            <%=MyUtil.ObjInput("Valor de Referencia","ValorRef",rs.getString("ValorRef"),true,true,520,100,"",true,true,20)%>
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
            <%=MyUtil.ObjChkBox("Requerido en Cambio","ReqCambio",rs.getString("ReqCambio"),true,true,450,250,"0","SI","NO","")%><%

        }
       else { %>
            <INPUT id='clCampoExtra' name='clCampoExtra' type='hidden' value='0'>
            <%=MyUtil.ObjInput("Nombre de Campo","Nombre","",true,true,20,100,"",true,true,20)%>
            <%=MyUtil.ObjComboC("Tipo de Objeto","clTipoObjeto","",true,true,180,100,"","Select * From cTipoObjeto Order by TipoObjeto","","",60,true,true)%>
            <%=MyUtil.ObjComboC("Tipo de Campo","clTipoCampo","",true,true,360,100,"","Select * From cTipoCampo Order by TipoCampo","","",60,true,true)%>
            <%=MyUtil.ObjInput("Valor de Referencia","ValorRef","",true,true,520,100,"",true,true,20)%>            
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
            <%=MyUtil.ObjChkBox("Requerido en Cambio","ReqCambio","",true,true,450,250,"0","SI","NO","")%><%
        }  %>        
          <%=MyUtil.DoBlock("Detalle de Campo Extra")%>                          
          <%=MyUtil.GeneraScripts()%><% 
        if (MyUtil.blnAccess[4]==true){
            
%>
<script>
     document.all.Nombre.maxLength=30;
     document.all.Longitud.maxLength=3;
     document.all.tSize.maxLength=3;
     document.all.EtiqChecked.maxLength=20;
     document.all.EtiqUnChecked.maxLength=20;
     document.all.Titulo.maxLength=50;
     document.all.ValorDefault.maxLength=50;
     document.all.SentenciaSQL.maxLength=200;
 </script>
<%
        }
    
    StrclPaginaWeb = null;
    StrclCampoExtra = null;
    StrSql = null;
    StrclUsrApp= null;

%>
</body>
</html>

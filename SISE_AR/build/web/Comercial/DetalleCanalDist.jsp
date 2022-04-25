<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        
        <script src='../Utilerias/Util.js'></script>
        <script src='../Utilerias/UtilDireccion.js'></script>
        
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String strclUsr = "0";
        String StrclCanalDist = "0";
        String StrNomOpe = "";
        
        
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if (request.getParameter("clCanalDistribucion")!= null)
        {
            StrclCanalDist= request.getParameter("clCanalDistribucion").toString();
        }
        if(StrclCanalDist.compareToIgnoreCase("0")==0)
        {
            if (session.getAttribute("clCanalDistribucion")!= null)
            {
                StrclCanalDist= session.getAttribute("clCanalDistribucion").toString();
            }
        }
        
        session.setAttribute("clCanalDistribucion",StrclCanalDist);
        
        StringBuffer StrSql1 = new StringBuffer();
        StrSql1.append(" select COALESCE(dsCanalDistribucion,'') 'dsCanalDistribucion', COALESCE(EF.dsEntFed,'') 'dsEntFed',");
        StrSql1.append(" COALESCE(EF.CodEnt,'') 'CodEnt', COALESCE(dsMunDel,'') 'dsMunDel',");
        StrSql1.append(" COALESCE(MD.CodMD,'')'CodMD', COALESCE(Colonia,'') 'Colonia',");
        StrSql1.append(" COALESCE(Calle,'')'Calle',COALESCE(CP,'')'CP',COALESCE(Referencia,'')'Referencia',COALESCE(RFC,'') RFC  ");
        StrSql1.append(" from cCanalDistribucion C ");
        StrSql1.append(" LEFT JOIN CENTFED EF ON(EF.CodEnt=C.CodEnt) " );
        StrSql1.append(" LEFT JOIN CMUNDEL MD ON(MD.CodMD=C.CodMD AND EF.CodEnt=MD.CodEnt)");
        StrSql1.append(" where clCanalDistribucion=").append(StrclCanalDist);
        ResultSet rs = UtileriasBDF.rsSQLNP( StrSql1.toString());
        StrSql1.delete(0,StrSql1.length());
        String StrclPaginaWeb = "388";
        
        session.setAttribute("clPaginaWebP",StrclPaginaWeb);
        %>
        <SCRIPT>fnOpenLinks()</script>
        <%
        
        MyUtil.InicializaParametrosC( 388,Integer.parseInt(strclUsr)); 
        %>
        <%=MyUtil.doMenuAct("../servlet/Utilerias.EjecutaAccion","fnLimpiaExtra()")%>
        <%="<INPUT id='URLBACK' name='URLBACK' type='hidden' value='"%><%=request.getRequestURL().substring(0,request.getRequestURL().lastIndexOf("/") + 1)%><%="DetalleCanalDist.jsp?'>"%>
        <%
        if (rs.next())
        {
            
        /* StrNomOpe = rs.getString("NombreOpe");
        session.setAttribute("NombreOpe",StrNomOpe);*/
        %>
        <INPUT id='clCanalDistribucion' name='clCanalDistribucion' type='hidden' value='<%=StrclCanalDist%>'>
        <%=MyUtil.ObjInput("Canal de Distribucion","dsCanalDistribucion",rs.getString("dsCanalDistribucion"),true,true,30,80,"",true,true,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed",rs.getString("dsEntFed"),false,false,30,150,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value='<%= rs.getString("CodEnt")%>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel",rs.getString("dsMunDel"),false,false,380,150,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value='<%= rs.getString("CodMD") %>'>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia",rs.getString("Colonia"),false,false,30,200,"",false,false,40)%>  
        <%=MyUtil.ObjInput("Calle y Número","Calle",rs.getString("Calle"),true,true,380,200,"",false,false,50)%>
        <div class='VTable' style='position:absolute; z-index:25; left:310px; top:160px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaCP2();' class='cBtn'></div>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.cp"),"CP",rs.getString("CP"),true,true,30,250,"",false,false,10)%>
        <%=MyUtil.ObjInput("Referencias","Referencia",rs.getString("Referencia"),true,true,380,250,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC",rs.getString("RFC"),true,true,30,300,"",true,true,50)%>
        <%=MyUtil.DoBlock("detalle Canal de distribución",220,0)%>
        <%
        
        
        }
        else
        {
        %>
        <INPUT id='clCanalDistribucion' name='clCanalDistribucion' type='hidden' value='<%=StrclCanalDist%>'>
        <%=MyUtil.ObjInput("Canal de Distribucion","dsCanalDistribucion","",true,true,30,80,"",true,true,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.entidad"),"dsEntFed","",false,false,30,150,"",false,false,50)%>
        <INPUT id='CodEnt' name='CodEnt' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.municipio"),"dsMunDel","",false,false,380,150,"",false,false,50)%>
        <INPUT id='CodMD' name='CodMD' type='hidden' value=''>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.colonia"),"Colonia","",false,false,30,200,"",false,false,40)%> 
        <%=MyUtil.ObjInput("Calle y Número","Calle","",true,true,380,200,"",false,false,50)%>
        <div class='VTable' style='position:absolute; z-index:25; left:310px; top:160px;'>
        <INPUT type='button' VALUE='Buscar..' onClick='fnBuscaColoniaCP2();' class='cBtn'></div>
        <%=MyUtil.ObjInput("Codigo Postal","CP","",true,true,30,250,"",false,false,10)%>
        <%=MyUtil.ObjInput("Referencias","Referencia","",true,true,380,250,"",false,false,50)%>
        <%=MyUtil.ObjInput(i18n.getMessage("message.title.rfc"),"RFC","",true,true,30,300,"",true,true,50)%>
        <%=MyUtil.DoBlock("detalle Canal de distribución",220,0)%>
        <%
        }	
        %>
        <%=MyUtil.GeneraScripts()%>
        <%
        rs.close();
        rs=null;
        
        strclUsr = null;
        StrclCanalDist = null;
        StrNomOpe = null;
        StrSql1 = null;
        StrclPaginaWeb = null;
        %>
        <script>  
function fnBuscaColoniaCP2(){
                if (document.all.btnGuarda.disabled==false){ 
                   var pstrCadena = "../Utilerias/FiltrosDireccion.jsp?strSQL=sp_WebBuscaDir 1,'','" + document.all.Colonia.value + "','" + document.all.CodEnt.value + "'";
                   pstrCadena = pstrCadena + "&Colonia=&CodMd=&dsMunDel=&CodEnt=&dsEntFed=&Tipo=1";
                   window.open(pstrCadena,'newWin','scrollbars=yes,status=yes,width=1,height=1');
                  } 
                }
        </script>                  
    </body>
</html>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='Utilerias/Util.js' ></script>
        <script src='Utilerias/UtilCuenta.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>
        <%
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        StringBuffer strSql= new StringBuffer();
        String strclCuenta="0";
        String strStrCuenta="";
        String StrCodEnt="";
        String NomConce="";
        String strclUsr="";
        StringBuffer strSalida = new StringBuffer();
        
        if(session.getAttribute("clCuenta")!=null)
        {
            strclCuenta = session.getAttribute("clCuenta").toString();
        }
        
        if (session.getAttribute("clUsrApp")!= null)
        {
            strclUsr = session.getAttribute("clUsrApp").toString();
        }
        
        if(request.getParameter("NomConce")!=null)
        {
            NomConce = request.getParameter("NomConce");
        }
        if(request.getParameter("CodEntEX")!=null)
        {
            StrCodEnt = request.getParameter("CodEntEX");
        }
        
        MyUtil.InicializaParametrosC(186,Integer.parseInt(strclUsr));
        %>
        <form id='Forma' name ='Forma' action='BuscaConcecionarioGM.jsp' method='get'>
            <%=MyUtil.ObjInput("Concecionario","NomConce","",true,true,25,25,"",false,false,50)%>    
            <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEntEX","", true,true,300,25,"","Select CodEnt,dsEntFed from cEntFed","","",50,false,false)%>    
            <div style="position:absolute; z-index:40; left:25px; top:70px;">
                <input class='cBtn' type='Button' value='Buscar...' onclick="document.all.Forma.submit()"></input>
            </div>       
        </form>           
        <%   
        
        strSql.append("sp_BuscaConcecionarioGM ").append(strclCuenta).append(",'").append(StrCodEnt).append("','").append(NomConce).append("'");
        // out.println(strSql.toString());
        //ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
        UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
        %>
        <div style="position:absolute; z-index:40; left:25px; top:100px;">
            <%
            out.print(strSalida);
            strSalida.delete(0,strSalida.length());
            %>
        </div>        
        <script>
            document.all.NomConce.readOnly=false;
            document.all.CodEntEXC.disabled=false;
        </script>    
        <%=MyUtil.GeneraScripts()%>
    </body>
</html>

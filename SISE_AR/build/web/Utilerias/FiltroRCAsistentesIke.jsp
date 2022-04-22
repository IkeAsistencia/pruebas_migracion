<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <%
            String strNombreUsr = "";
            String strCriterio = "0";
            String strclUsrApp = "";
            StringBuffer strSql= new StringBuffer();

            if (request.getParameter("NombreUsr")!= null)
            {
                strNombreUsr = request.getParameter("NombreUsr").toString().trim();
            }

            if (request.getParameter("Criterio")!= null)
            {
                strCriterio = request.getParameter("Criterio").toString();
            }

            if (!strNombreUsr.equalsIgnoreCase(""))
            {
                if(strCriterio.compareToIgnoreCase("0")!=0)
                {
                    strSql.append(" Select U.Nombre, U.clUsrApp ");
                    strSql.append(" from cUsrApp U ");
                    strSql.append(" inner join UsrxGpo UG on (UG.clUsrApp=U.clUsrApp) ");
                    strSql.append(" where UG.clGpoUsr = 151 and U.nombre like '%").append(strNombreUsr).append("%'");
                }
                else
                {
                    strSql.append(" Select U.Nombre, U.clUsrApp ");
                    strSql.append(" from cUsrApp U ");
                    strSql.append(" inner join UsrxGpo UG on (UG.clUsrApp=U.clUsrApp) ");
                    strSql.append(" where UG.clGpoUsr in (151,152) and U.nombre like '%").append(strNombreUsr).append("%'");
                }

                ResultSet rsUsr = UtileriasBDF.rsSQLNP( strSql.toString());
                if(rsUsr.next())
                {
                    if(rsUsr.isLast())
                    {
%>
                        <script>top.opener.fnActualizaDatosUsuario('<%=rsUsr.getString("Nombre")%>',<%=rsUsr.getString("clUsrApp")%>);window.close()</script>
<%
                     strSql.delete(0,strSql.length());
                     return;
                     }
                 }
                 rsUsr.close();
            }

            strSql.delete(0,strSql.length());
            if (request.getParameter("strSQL")!= null)
            {
                strSql.append(request.getParameter("strSQL").toString());
                strSql.append(" '").append(strNombreUsr).append("',").append(strCriterio);
                System.out.println("Procedure: " +  strSql);
            }

            MyUtil.InicializaParametrosC(167,Integer.parseInt("1"));

            %><form id='Forma' name ='Forma' action='FiltroRCAsistentesIke.jsp' method='get'>
        <input type='hidden' id='strSQL' name='strSQL' value="st_RCBuscaAsistentesIke"></input>
            <%=MyUtil.ObjInput("NombreUsr","NombreUsr",strNombreUsr,true,true,25,90,"",false,false,50)%>
        <INPUT id='Criterio' name='Criterio' type='hidden' value='<%= strCriterio %>'>
            <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
        </form>
        <script>document.all.NombreUsr.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
        <%
            if (strNombreUsr!="" && (strSql.length()>0)){
                StringBuffer strSalida = new StringBuffer();
                UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
        %>
        <%=strSalida.toString()%>
        <%
        strSalida.delete(0,strSalida.length());
        }

                strSql.delete(0,strSql.length());

                %>

        </body>
</html>

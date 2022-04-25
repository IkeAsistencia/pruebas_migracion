<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
    <head>
        <title></title>
    </head>
    <body class="cssBody">
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilDireccion.js' ></script>
        
        <%  
        com.ike.util.I18N i18n = com.ike.util.I18N.getInstance("es","AR");
        String strdsReferencia= "";
        String strCodMd = "";
        String strCodEnt = "";
        StringBuffer strSql= new StringBuffer();
        String strTipo="";
        String StrdsCuenta="";
        String StrclCuenta="";
        String strclCategoria="";
        String strclSubcategoria="";
        String StrclExpediente = "0";
        
        
        
        if (session.getAttribute("clExpediente")!= null)
        {
            StrclExpediente = session.getAttribute("clExpediente").toString();
        }
        
        strSql.append(" Select coalesce(C.clCuenta,'') as clCuenta, coalesce(C.dsCuenta,'') as dsCuenta ");
        strSql.append(" From Expediente E");
        strSql.append(" Inner Join cCuenta C on (C.clCuenta=E.clCuenta) ");
        strSql.append(" Where E.clExpediente=").append(StrclExpediente);
        
        ResultSet rs2 = UtileriasBDF.rsSQLNP( strSql.toString());
        
        if (rs2.next())
        {
            strSql.delete(0,strSql.length());
            if (request.getParameter("strSQL")!= null)
            {
                strSql.append(request.getParameter("strSQL").toString());
            }
            else
            {
        %>Falta definir stored procedure<%
        return;
            }
            StrclCuenta = rs2.getString("clCuenta");
            StrdsCuenta = rs2.getString("dsCuenta");
            strSql.append(" '").append(StrclCuenta).append("'");
        }
        else
        {
        %>El expediente no existe<% return;
        }

        if (request.getParameter("Tipo")!= null)
        {
        strTipo = request.getParameter("Tipo").toString();
        strSql.append(",").append("'").append(strTipo).append("'");
        }
        else
        {
        strSql.append(",''");
        }

        if (request.getParameter("dsReferencia")!= null)
        {
        strdsReferencia = request.getParameter("dsReferencia").toString();
        strSql.append(",").append("'").append(strdsReferencia).append("'");
        }
        else
        {
        strSql.append(",''");
        }

        if (request.getParameter("CodEnt")!= null)
        {
        strCodEnt= request.getParameter("CodEnt").toString();
        strSql.append(",").append("'").append(strCodEnt).append("'");
        }
        else
        {
        strSql.append(",''");
        }

        if (request.getParameter("CodMD")!= null)
        {
        strCodMd= request.getParameter("CodMD").toString();
        strSql.append(",").append("'").append(strCodMd).append("'");
        }
        else
        {
        strSql.append(",").append("''");
        }

        if (request.getParameter("clCategoria")!= null)
        {
        strclCategoria = request.getParameter("clCategoria").toString();
        strSql.append(",").append("'").append(strclCategoria).append("'");
        }
        else
        {
        strSql.append(",''");
        }
        if (request.getParameter("clSubCategoria")!= null)
        {
        strclSubcategoria= request.getParameter("clSubCategoria").toString();
        strSql.append(",").append("'").append(strclSubcategoria).append("'");
        }
        else
        {
        strSql.append(",").append("''");
        }

        MyUtil.InicializaParametrosC(238,Integer.parseInt("1")); 
        
        %><form id='Forma' name ='Forma' action='FiltrosReferencia.jsp' method='get'>
            <input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaRef "></input>
            <%=MyUtil.ObjInput("Cuenta","dsCuenta",StrdsCuenta,true,true,15,50,StrdsCuenta,false,false,58)%>
            <INPUT id='clCuenta' name='clCuenta' type='hidden' value=<%=StrclCuenta%>>
                <%=MyUtil.ObjComboC("Categoría","clCategoria","",true,true,335,50,"","Select clCategoria, dsCategoria From cCategoria Order by dsCategoria","fnLlenaSubCategoria()","",30,false,false)%>
                <%=MyUtil.ObjComboC("Subcategoría","clSubCategoria","",true,true,535,50,"","Select clSubCategoria, dsSubCategoria From cSubCategoria Where clCategoria='0' Order by dsSubCategoria ","","",30,false,false)%>
                <%=MyUtil.ObjInput("Nombre","dsReferencia","",true,true,15,90,"",false,false,35)%>
                <%=MyUtil.ObjChkBox("Tipo de Ref","Tipo","0", true,true,215,87,"","Particular","General","")%>
                <%=MyUtil.ObjComboC(i18n.getMessage("message.title.entidad"),"CodEnt","",true,true,335,90,"","Select CodEnt,dsEntFed from cEntFed order by dsEntFed","fnLlenaMunicipios()","",30,false,false)%>
                <%=MyUtil.ObjComboC(i18n.getMessage("message.title.municipio"),"CodMD","",true,true,535,90,"","SELECT CodMD,dsMunDel  FROM cMunDel WHERE CodMD='' ORDER BY dsMunDel","","",40,false,false)%>
                
                <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
        </form>
        <script>document.all.CodEntC.disabled=false;document.all.TipoC.disabled=false;document.all.CodMDC.disabled=false;document.all.clCategoriaC.disabled=false;document.all.clSubCategoriaC.disabled=false;document.all.dsReferencia.readOnly=false;window.resizeTo(1000,500);</script>
        <br><br><br><br><br><br><br><br>
        <%
        if (strSql.length()>0)
        {
            StringBuffer strSalida = new StringBuffer();
            UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
        %>
        <%=strSalida.toString()%>
        <%
        strSalida.delete(0,strSalida.length());
        }
        strSql.delete(0,strSql.length());
        rs2.close();
        rs2=null;
        
        
        %>
        
        
        <script>
     function fnLlenaSubCategoria(){ 
        var strConsulta = "sp_GetSubCategoria " + document.all.clCategoria.value;
        var pstrCadena = "../servlet/Utilerias.LlenaCombos?strSQL=" + strConsulta;
        document.all.clSubCategoria.value = '';
        pstrCadena = pstrCadena + "&strName=clSubCategoriaC";		
        fnOptionxDefault('clSubCategoriaC',pstrCadena);
    }     
    
    
       
        </script>
    </body>
</html>

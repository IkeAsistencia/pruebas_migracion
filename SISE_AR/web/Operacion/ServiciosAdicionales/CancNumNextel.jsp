<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<html>
<head><title>JSP Page</title>
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
</head>
<body class="cssBody">
<%-- <jsp:useBean id="beanInstanceName" scope="session" class="beanPackage.BeanClassName" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
<script src='../../Utilerias/Util.js' ></script>
<%
    String StrclEmpresa="0";

    int iCont=0;
    int i=0;
   
    if (request.getParameter("clEmpresa")!= null)
    {
         StrclEmpresa = request.getParameter("clEmpresa").toString().trim();
    }   
    
    StringBuffer StrSql = new StringBuffer();
       
    StrSql.append(" SELECT TA.clave ");
    StrSql.append(" FROM  cEmpresaNextel TE ");
    StrSql.append(" INNER JOIN AfiliadoInfoAdicionalNXT AD ON(AD.CuentaNextel=TE.CuentaNextel AND TE.clEmpresaNextel =").append(StrclEmpresa).append(")");
    StrSql.append(" INNER JOIN cAfiliadoNXT TA ON(AD.clAfiliado=TA.clAfiliado) ");    
    StrSql.append(" LEFT JOIN CancelacionesNextel CN on (TA.Clave = CN.NumNextel) ");    
    StrSql.append(" WHERE ta.activo=1 AND ta.fechabaja IS NULL AND  ");    
    StrSql.append(" (CN.numNextel is null or (CN.numNextel is not null and cn.status =2)) ORDER BY TA.clave ");    
    
    out.println(StrSql.toString());
    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
    StrSql.delete(0,StrSql.length());
    %>
    <form target='numerosnextel' method='get' action='CancNumNextel.jsp'>
    <table><tr class='cssTitDet'><td colspan=2>Activos Nextel</td></tr>
    <%    
    while(rs.next()) {
        %>
        <tr><td width='50'><input id='Folios' name='Folios' type='checkbox' ></input></td>
        <td><INPUT disabled='true' id='Clave' name='Clave' type='text' value='<%=rs.getString("Clave")%>'></td>
        </tr>
        <%
        i=i+1;
        iCont=iCont+1;
    } // fin while
    rs.close();
    rs=null;
    
%>
    <textarea name='Resultados' id='Resultados' cols='80' rows='3' ></textarea>
    <input type='hidden' name='Cuenta' id='Cuenta' value ='<%=iCont%>'></input><tr><td></tr></td>
<!--    <tr><td></tr></td><tr><td><center><input type='submit' name='submit' value='Desasignar' onclick='fnConcatena()'></input></center></td></tr>  -->
    </form>
<script>

  document.all.Resultados.style.visibility='hidden';
/*
  function fnConcatena(){
        i=0;
        document.all.Resultados.value=='';

		if	(document.all.Cuenta.value==1){
		   if (document.all.Folios.checked){
				if (document.all.Resultados.value==''){
					document.all.Resultados.value = document.all.clFolioAfianzadora.value;
				}
				else{
					document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clFolioAfianzadora.value;
				} 
			} 
		}else{
			while (i<=document.all.Cuenta.value-1){
						//document.all.Folios(i).checked;
				   if (document.all.Folios(i).checked){
				   
						if (document.all.Resultados.value==''){
							document.all.Resultados.value = document.all.clFolioAfianzadora(i).value;
						}
						else{
							document.all.Resultados.value = document.all.Resultados.value + ',' + document.all.clFolioAfianzadora(i).value;
						} 
					} 
					i++;
			}
		}
   }
 */
</script>
</body>
</html>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Seguridad.SeguridadC,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<script src='../../Utilerias/Util.js'></script>
<%  
        String StrclExpediente = "0";
    	String StrclGpoCob = "0";
        int iCont =0;
        
        

        if (request.getParameter("clGpoCob")!= null)
        {
            StrclGpoCob= request.getParameter("clGpoCob").toString().trim(); 
        }  
        
      	if (session.getAttribute("clExpediente")!= null)
      	{
            StrclExpediente= session.getAttribute("clExpediente").toString(); 
       	}  

        StringBuffer StrSql = new StringBuffer();
        
        StrSql.append(" Select clPrefijo,Prefijo,Descrip ");
        StrSql.append(" from cCoberturaSB where clGpoCob=").append(StrclGpoCob);

        ResultSet rs=UtileriasBDF.rsSQLNP( StrSql.toString());
        StrSql.delete(0,StrSql.length());
        
%>
    <form method='post' action='CobxExpedInsert.jsp'>    
    <div style='position:absolute; z-index:303; left:30px; top:10px'>
    <input type='reset' value='Cancelar' onclick=''></input>
    <input type='submit' value='Aceptar' onclick='fnConcatena()'></input>
    </div>
    <INPUT id='clExpediente' name='clExpediente' type='hidden' value='<%=StrclExpediente%>'>
<textarea name='CoberturaSeleccionada' id='CoberturaSeleccionada' cols='50' rows='2' ></textarea>
	<table><tr><td class='cssTitDet' colspan=2>Seleccione Cobertura</td></tr>
        <tr class='TTable'><td> - </td><td class='TTable' width='500px'>Descripcion</td></tr>
<%
 while(rs.next()) {
%>        
        <tr><td><input id='Cobertura' name='Cobertura' type='checkbox'></input></td>
        <td><INPUT disabled='true' id='Descripcion'  name='Descripcion' size='60' type='text' value='<%=rs.getString("Descrip")%>'></td>
        <td><INPUT disabled='true' id='clPrefijo' name='clPrefijo'  type='hidden' value='<%=rs.getString("clPrefijo")%>'></td>
        </tr>
<%        iCont=iCont+1;
    }; // fin while  
    rs.close();
    rs=null;
    
%>
    <input type='hidden' name='Total' id='Total' value ='<%=iCont%>'></input>
    </form>
    </table>

<script>
document.all.CoberturaSeleccionada.style.visibility='hidden';

    function fnConcatena(){
        i=0;
        document.all.CoberturaSeleccionada.value='';        
        if (document.all.Total.value>1){
            while (i < document.all.Total.value){
                        //document.all.Cobertura(i).checked;
                   if (document.all.Cobertura(i).checked){
                   
                        if (document.all.CoberturaSeleccionada.value==''){
                            document.all.CoberturaSeleccionada.value = document.all.clPrefijo(i).value;
                        }
                        else{
                            document.all.CoberturaSeleccionada.value = document.all.CoberturaSeleccionada.value + ',' + document.all.clPrefijo(i).value;
                        } 
                    } 
                    i++;
            } 
        }else{
               if (document.all.Cobertura.checked){

                    if (document.all.CoberturaSeleccionada.value==''){
                        document.all.CoberturaSeleccionada.value = document.all.clPrefijo.value;
                    }
                    else{
                        document.all.CoberturaSeleccionada.value = document.all.CoberturaSeleccionada.value + ',' + document.all.clPrefijo.value;
                    } 
                } 
        }
    }
</script>
</body>
</html>

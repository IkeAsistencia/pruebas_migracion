<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet,Utilerias.UtileriasBDF" errorPage="" %>
<html>
<head>
<title></title>
</head>
<body class="cssBody">
<link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
<jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj"/>

<%  
    	String strClave = "";
    	String strclCuenta = "";
        StringBuffer strSql= new StringBuffer(); 
    
    

      	if (request.getParameter("Clave")!= null)
      	{
             strClave = request.getParameter("Clave").toString().trim();
        }  
        
        if (request.getParameter("clCuenta")!= null)
      	{
             strclCuenta = request.getParameter("clCuenta").toString().trim();
        }  
        
        if (strClave.compareToIgnoreCase("")!=0){

            if(strclCuenta.compareToIgnoreCase("")==0){
                strSql.append(" Select ");
                strSql.append(" C.clCuenta, C.Nombre, PC.Prefijo, C.clTipoValidacion, coalesce(TC.Mask,'') Mask, ");
                strSql.append(" coalesce(TC.MaskUsr,'') MaskUsr, coalesce(Agentes.TotAgentes,0) TotAgentes ");
                strSql.append(" From PrefijoxCuenta PC");
                strSql.append(" inner join cCuenta C on (PC.clCuenta=C.clCuenta)");
                strSql.append(" left join cTipoClave TC on (C.clTipoClave = TC.clTipoClave) ");
                strSql.append(" left join (select clCuenta, count(*) TotAgentes from cAgentexCta group by clCuenta) Agentes on (C.clCuenta = Agentes.clCuenta) ");
                strSql.append(" where patindex('%' + ltrim(rtrim(PC.Prefijo)) + '%','").append(strClave).append("') > 0 ");
            }else{
                strSql.append(" Select "); 
                strSql.append(" C.clCuenta, C.Nombre, PC.Prefijo, C.clTipoValidacion, coalesce(TC.Mask,'') Mask, "); 
                strSql.append(" coalesce(TC.MaskUsr,'') MaskUsr, coalesce(Agentes.TotAgentes,0) TotAgentes "); 
                strSql.append(" From cCuenta C "); 
                strSql.append(" left join cTipoClave TC on (C.clTipoClave = TC.clTipoClave) "); 
                strSql.append(" left join PrefijoxCuenta PC on (PC.clCuenta=C.clCuenta)"); 
                strSql.append(" left join (select clCuenta, count(*) TotAgentes from cAgentexCta group by clCuenta) Agentes on (C.clCuenta = Agentes.clCuenta) "); 
                strSql.append(" where patindex('%' + ltrim(rtrim(PC.Prefijo)) + '%','").append(strClave).append("') > 0 "); 
                strSql.append(" and C.clGrupoCuenta in (Select clGrupoCuenta from cCuenta where clCuenta = ").append(strclCuenta).append(")");
            }
            ResultSet rs = UtileriasBDF.rsSQLNP( strSql.toString());
            strSql.delete(0,strSql.length());
            
            if(rs.next()){
                if(rs.isLast()){
                    String StrrsclCuenta="";
                    StrrsclCuenta = rs.getString("clCuenta");
                    if(StrrsclCuenta.compareToIgnoreCase(strclCuenta)!=0) {
                        %><div class='VTable' style='position:absolute; z-index:20; left:100px; top:50px;'>
                        <table><td class='cBTN'>El Prefijo de la Clave pertenece a otra Cuenta diferente a la seleccionada</td></table></div>
                     <%
                    }else{
                        %><script>top.opener.fnActualizaDatosCuenta('<%=rs.getString("Nombre")%>','<%=StrrsclCuenta%>','<%=rs.getString("clTipoValidacion")%>','<%=rs.getString("Mask")%>','<%=rs.getString("MaskUsr")%>','<%=rs.getString("TotAgentes")%>')</script>
                        <script>window.close()</script>
                        <%
                        strSql.delete(0,strSql.length());
                        return;
                    }
                }
                rs.close();
                rs=null;
            } else {
                rs.close();
                rs=null;
                if(strclCuenta.compareToIgnoreCase("")==0){
                    %><script>window.close();</script>
                <% }else{
                    strSql.append("                 select PC.clCuenta, count(*) TotPref ");
                    strSql.append("                 from PrefijoxCuenta PC");
                    strSql.append("                 inner join cCuenta C on (PC.clCuenta=C.clCuenta)");
                    strSql.append("                 where PC.clCuenta = ").append(strclCuenta);
                    strSql.append("                 group by PC.clCuenta ");
                    
                    rs=null;
                    rs = UtileriasBDF.rsSQLNP( strSql.toString());

                    if (rs.next()){
                        if (rs.getString("TotPref").compareToIgnoreCase("0")==0){
                           %><script>window.close();</script>
                        <% }else{
                            %><div class='VTable' style='position:absolute; z-index:20; left:100px; top:50px;'>
                            <table><td class='cBTN'>El Prefijo de la Clave No coincide con los de la cuenta</td></table></div>
                        <%
                            strclCuenta="";
                         }
                        
                    }else{
                           %><script>window.close();</script><%
                    }
                    rs.close();
                    rs=null;
                }
             }
        }else{
               %><script>window.close();</script>
               <%
               strSql.delete(0,strSql.length());
               return;
        }

        strSql.delete(0,strSql.length());
        
        if (strclCuenta.compareToIgnoreCase("")!=0){
            strSql.append("sp_WebBuscaClaveGpo ");
            strSql.append(" '").append(strClave).append("','").append(strclCuenta).append("'");
        } else{
            strSql.append("sp_WebBuscaClave ");
            strSql.append(" '").append(strClave).append("'");
        }
        
       	MyUtil.InicializaParametrosC(346,Integer.parseInt("1")); 

	%><form id='Forma' name ='Forma' action='FiltrosClave.jsp' method='get'>
	<input type='hidden' id='strSQL' name='strSQL' value="sp_WebBuscaClave"></input>
	<%=MyUtil.ObjInput("Prefijo","Clave",strClave,true,true,25,90,"",false,false,50)%>
        <P align='left'><input type='button' value='BUSCAR...' onClick='document.all.Forma.submit()' class='cBtn'></input></p>
        </form><script>document.all.Clave.readOnly=false;window.resizeTo(700,500);</script><br><br><br><br><br>
        <%
        StringBuffer strSalida = new StringBuffer();
        UtileriasBDF.rsTableNP(strSql.toString(),strSalida);
        %>
           <%=strSalida.toString()%>
        <%
        strSalida.delete(0,strSalida.length());
        strSql.delete(0,strSql.length());
        
%>

</body>
</html>

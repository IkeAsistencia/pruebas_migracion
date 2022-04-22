<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Timestamp,java.util.Calendar,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Reporte de Tiempos de Servicio de Asesoria Legal</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableGpo {background-color: #ffffff;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}            
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;} 
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: left;}
        </style>
        <%!
            String Mes2Str(int mes) {

                String strMes = "";

                switch(mes){ 
                    case 0: strMes = ""; break;
                    case 1: strMes = "Enero"; break;
                    case 2: strMes = "Febrero"; break;
                    case 3: strMes = "Marzo"; break;
                    case 4: strMes = "Abril"; break;
                    case 5: strMes = "Mayo"; break;
                    case 6: strMes = "Junio"; break;
                    case 7: strMes = "Julio"; break;
                    case 8: strMes = "Agosto"; break;
                    case 9: strMes = "Septiembre"; break;
                    case 10: strMes = "Octubre"; break;
                    case 11: strMes = "Noviembre"; break;
                    case 12: strMes = "Diciembre"; break;
                }
                return strMes;
            };
        %>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../Utilerias/Util.js' ></script>
        <script src='../Utilerias/UtilMask.js'></script>       
        <%                                
            StringBuffer StrSql = new StringBuffer();
            String StrclUsrApp="0";
            String StrclAnio = "";
            String clMes = "";
            String Mes = "";
            String StrRow = "";
            String StrQry="";
            String StrInicia=""; 
            
            long tiempo = System.currentTimeMillis(); 
            
            Calendar cal = Calendar.getInstance();
            Timestamp timeStamp = new Timestamp(cal.getTimeInMillis());
            StrInicia=timeStamp.toString().substring(0,19);   
            
            cal=null; 
            timeStamp=null; 
            
            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
            StrclUsrApp=null;
            return;
            }
            MyUtil.InicializaParametrosC( 685,Integer.parseInt(StrclUsrApp));
        %>
        <form name='frmBusq' id='frmBusq' method='post' action='../EstadisticosGNP/RptServicioAseLegalGNP.jsp'>
            <%--=MyUtil.ObjComboC("Año","clAnio","",true,true,20,30,"","st_GetAnio2","","",25,true,true)%>
            <%=MyUtil.ObjComboC("Mes","clmes","",true,true,180,30,"","sp_MesesEnCurso","","",25,true,true)--%>
            <%=MyUtil.ObjComboC("Año","clAnio","",true,true,20,30,"","sp_GetAnio","","",25,true,true)%>
            <%=MyUtil.ObjComboC("Mes","clmes","",true,true,180,30,"","sp_nombremeses","","",25,true,true)%>            
            <%=MyUtil.DoBlock("Parametros de Busqueda",70,0)%>
            <div class='VTable' style='position:absolute; z-index:20; left:350px; top:41px;'> 
                <input type="button" class="cBtn" value="Buscar.." onclick="this.form.submit();">
            </div>
        </form>
        <%
            if(request.getParameter("clAnio")!= null){
                StrclAnio = request.getParameter("clAnio");
            }
            if(request.getParameter("clmes")!= null){
                clMes = request.getParameter("clmes");
                if(!clMes.equalsIgnoreCase("")){
                    Mes = Mes2Str(Integer.parseInt(clMes));
                }
            }

            StrSql.append("st_GNPRptTmpSerAseLeg '").append(StrclAnio).append("','").append(clMes).append("'");
            StrQry="st_GNPRptTmpSerAseLeg "+StrclAnio+","+clMes;
            
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());
                        
            java.sql.ResultSetMetaData infoResulSet =   null;
            infoResulSet = rs.getMetaData();

            if(infoResulSet.getColumnCount() != 1){

                if(rs.next()){
        %> 
        <div style='position:absolute; z-index:20; left:10px; top:120px;'> 
            
            <font class="STableTitRpt"> <center>Tiempos de Servicio de Asesoria Legal<br><br><%=Mes + " " + StrclAnio%></center> </font><br>
            
            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr> 
                    <!--<td colspan="4" rowspan="2" class="STableTit">&nbsp;</td>
                    <td colspan="2" class="STableTit">PERIFERIA</td>
                    <td colspan="2" class="STableTit">PACIFICO (GUADALAJARA)</td>
                    <td colspan="2" class="STableTit">NORTE</td>
                    <td colspan="2" class="STableTit">PACIFICO (MEXICALI)</td>
                    <td colspan="2" class="STableTit">SUR</td>
                    <td colspan="2" class="STableTit">GRAN TOTAL</td>-->
                    
                    <td colspan="4" rowspan="2" class="STableTit">&nbsp;</td>
                    <td colspan="2" class="STableTit">NORTE</td>
                    <td colspan="2" class="STableTit">PACIFICO (GUADALAJARA)</td>
                    <td colspan="2" class="STableTit">PACIFICO (MEXICALI)</td>
                    <td colspan="2" class="STableTit">PERIFERIA</td>
                    <td colspan="2" class="STableTit">SUR</td>
                    <td colspan="2" class="STableTit">GRAN TOTAL</td>                    
                    
                </tr>
                <tr> 
                    <td width="5%" class="STableTit"># Siniestros</td>
                    <td width="5%" class="STableTit">% Division</td>
                    <td width="5%" class="STableTit"># Siniestros</td>
                    <td width="5%" class="STableTit">% Division</td>
                    <td width="5%" class="STableTit"># Siniestros</td>
                    <td width="5%" class="STableTit">% Division</td>
                    <td width="5%" class="STableTit"># Siniestros</td>
                    <td width="5%" class="STableTit">% Division</td>
                    <td width="5%" class="STableTit"># Siniestros</td>
                    <td width="5%" class="STableTit">% Division</td>
                    <td width="5%" class="STableTit"># Siniestros</td>
                    <td width="5%" class="STableTit">% Division</td>
                </tr>
                <tr> 
                    <td width="2%" rowspan="14" class="STableR2">SINIESTROS</td>
                    <td width="2%" rowspan="14" class="STableR1">TIEMPOS DE:</td>
                    <td width="2%" rowspan="6" class="STableR2">ASIGNACIÓN</td>                    
                    <td width="24%" class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1"><%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1"><%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1"><%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                </tr> <%if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2"><%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2"><%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2"><%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>                    
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1"><%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1"><%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1"><%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2"><%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2"><%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2"><%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1"><%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1"><%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1"><%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableTit"><%=rs.getString(2)%></td>
                    <td class="STableTit"><%=rs.getString(3)%></td>
                    <td class="STableTit"><%=rs.getString(4)%></td>
                    <td class="STableTit"><%=rs.getString(5)%></td>
                    <td class="STableTit"><%=rs.getString(6)%></td>
                    <td class="STableTit"><%=rs.getString(7)%></td>
                    <td class="STableTit"><%=rs.getString(8)%></td>
                    <td class="STableTit"><%=rs.getString(9)%></td>
                    <td class="STableTit"><%=rs.getString(10)%></td>
                    <td class="STableTit"><%=rs.getString(11)%></td>
                    <td class="STableTit"><%=rs.getString(12)%></td>
                    <td class="STableTit"><%=rs.getString(13)%></td>
                    <td class="STableTit"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td rowspan="8" class="STableR1">ARRIBO</td>
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1"><%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1"><%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1"><%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2"><%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2"><%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2"><%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1"><%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1"><%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1"><%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2"><%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2"><%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2"><%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1"><%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1"><%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1"><%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2"><%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2"><%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2"><%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableTit"><%=rs.getString(2)%></td>
                    <td class="STableTit"><%=rs.getString(3)%></td>
                    <td class="STableTit"><%=rs.getString(4)%></td>
                    <td class="STableTit"><%=rs.getString(5)%></td>
                    <td class="STableTit"><%=rs.getString(6)%></td>
                    <td class="STableTit"><%=rs.getString(7)%></td>
                    <td class="STableTit"><%=rs.getString(8)%></td>
                    <td class="STableTit"><%=rs.getString(9)%></td>
                    <td class="STableTit"><%=rs.getString(10)%></td>
                    <td class="STableTit"><%=rs.getString(11)%></td>
                    <td class="STableTit"><%=rs.getString(12)%></td>
                    <td class="STableTit"><%=rs.getString(13)%></td>
                    <td class="STableTit"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2"><%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2"><%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2"><%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                </tr> <%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td colspan="4" class="STableTit"><%=rs.getString(2)%></td>
                    <td class="STableTit"><%=rs.getString(3)%></td>
                    <td class="STableTit"><%=rs.getString(4)%></td>
                    <td class="STableTit"><%=rs.getString(5)%></td>
                    <td class="STableTit"><%=rs.getString(6)%></td>
                    <td class="STableTit"><%=rs.getString(7)%></td>
                    <td class="STableTit"><%=rs.getString(8)%></td>
                    <td class="STableTit"><%=rs.getString(9)%></td>
                    <td class="STableTit"><%=rs.getString(10)%></td>
                    <td class="STableTit"><%=rs.getString(11)%></td>
                    <td class="STableTit"><%=rs.getString(12)%></td>
                    <td class="STableTit"><%=rs.getString(13)%></td>
                    <td class="STableTit"><%=rs.getString(14)%></td>
                </tr>
                <%}%>
            </table>
        </div>
        <%
            StrSql.delete(0,StrSql.length());
            rs = null;
                    }

                    String insert = " Insert into BitacoraReportes (InicioEjecucion,FinEjecucion,TiempoEjecucion,QueryEjecutado,clUsrApp) values (";
                    UtileriasBDF.ejecutaSQLNP(insert+"'"+StrInicia+ "','"+StrInicia+"',"+((System.currentTimeMillis()-tiempo)/1000)+",'"+StrQry+"',"+StrclUsrApp+")");
                    StrInicia=null;
                    StrQry=null;
                    insert=null;
                    
                }else{
                    if(rs.next()){
        %>
        <div style='position:absolute; z-index:20; left:10px; top:100px;'> 
            <table border="0" cellspacing="1" cellpadding="1">
                <tr><td class="STableTit"><%=infoResulSet.getColumnName(1)%></td></tr>
                <tr><td class="STableTexto"><%=rs.getString("Mensaje").toUpperCase()%></td></tr>
            </table>
        </div>
        <%
            } }                                                
        %>
        <script>
            document.all.clAnioC.disabled=false;
            document.all.clmesC.disabled=false;
        </script>
    </body>
</html>




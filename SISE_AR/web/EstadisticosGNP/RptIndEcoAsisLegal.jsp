<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Timestamp,java.util.Calendar,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Indicadores Economicos de Asistencia Legal</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableGpo {background-color: #ffffff;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}            
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;} 
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
            .STableReg{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: left;}
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
            String clTipo = "0";
            String Mes = "";
            String StrRow = "";
            String StrQry="";
            String StrInicia="";
            
            long tiempo = System.currentTimeMillis();
            
            Calendar cal = Calendar.getInstance();
            Timestamp timeStamp= new Timestamp(cal.getTimeInMillis());
            StrInicia = timeStamp.toString().substring(0,19);
            
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
            MyUtil.InicializaParametrosC(687,Integer.parseInt(StrclUsrApp));
        %>
        <form name='frmBusq' id='frmBusq' method='post' action='../EstadisticosGNP/RptIndEcoAsisLegal.jsp'>
            <%--=MyUtil.ObjComboC("Año","clAnio","",true,true,20,30,"","st_GetAnio2","","",25,true,true)%>
            <%=MyUtil.ObjComboC("Mes","clmes","",true,true,180,30,"","sp_MesesEnCurso","","",25,true,true)--%>
            <%=MyUtil.ObjComboC("Año","clAnio","",true,true,20,30,"","sp_GetAnio","","",25,true,true)%>
            <%=MyUtil.ObjComboC("Mes","clmes","",true,true,180,30,"","sp_NombreMeses","","",25,true,true)%>            
            <%=MyUtil.ObjComboC("Tipo Reporte","clTipo","",true,true,340,30,"","Select '1' 'clTipo','Mensual' 'dsTipo' Union Select '2' 'clTipo','Acumulado' 'dsTipo'","","",25,true,true)%>
            <%=MyUtil.DoBlock("Parametros de Busqueda",70,0)%>
            <div class='VTable' style='position:absolute; z-index:30; left:520px; top:41px;'> 
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

                if(request.getParameter("clTipo")!= null){
                    if(!request.getParameter("clTipo").equalsIgnoreCase(" ")){
                        clTipo = request.getParameter("clTipo");
                    }
                }

                StrSql.append("st_GNPRptIndEcoAsisLeg '").append(StrclAnio).append("','").append(clMes).append("'").append(",'").append(clTipo).append("'");
                
                StrQry="st_GNPRptIndEcoAsisLeg "+StrclAnio+","+clMes+","+clTipo;
                
                ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());

                java.sql.ResultSetMetaData infoResulSet =   null;
                infoResulSet = rs.getMetaData();

                if(infoResulSet.getColumnCount() != 1){

                    if(rs.next()){
        %> 
        <div style='position:absolute; z-index:20; left:10px; top:120px;'> 
            <font class="STableTitRpt"> 
            <center>
                    Indicadores Economicos de Asistencia Legal<br><br> 
                    <% 
                    //if(clTipo.equalsIgnoreCase("2")){out.println("Acumulado Enero - " + Mes + " " + StrclAnio);}else{out.println(Mes);}
                    if(clTipo.equalsIgnoreCase("2")){%><%="Acumulado Enero - " + Mes + " " + StrclAnio%><%}else{%><%=Mes+" "+StrclAnio%><%}
                    %>
            </center> 
            </font>
            <br>
            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr> 
                    <td width="20%" rowspan="2" class="STableTit">Regional</td>
                    <td colspan="4" class="STableTit">Fianzas</td>
                    <td colspan="2" class="STableTit">Cauciones</td>
                    <td colspan="2" class="STableTit">Recuperacion de terceros</td>
                    <td colspan="4" class="STableTit">Asuntos Pendientes</td>
                    <td colspan="2" class="STableTit">&nbsp;</td>
                </tr>
                <tr> 
                    <td width="6%" class="STableTit">Num.</td>
                    <td width="8%" class="STableTit">Fianzas Exh.(Monto)</td>
                    <td width="6%" class="STableTit">Num.</td>
                    <td width="8%" class="STableTit">Fianzas Rec.(Monto)</td>
                    <td width="6%" class="STableTit">Num Exh.</td>
                    <td width="6%" class="STableTit">Num Rec.</td>
                    <td width="6%" class="STableTit">Num.</td>
                    <td width="8%" class="STableTit">Rec. 3ros.(Monto)</td>
                    <td width="6%" class="STableTit">Saldo Inicial</td>
                    <td width="6%" class="STableTit">Asignados</td>
                    <td width="6%" class="STableTit">Terminados</td>
                    <td width="8%" class="STableTit">Saldo Final</td>
                    <td width="5%" class="STableTit">Ahorros</td>
                    <td width="5%" class="STableTit">Promedio Rc</td>
                </tr>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1">$<%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1">$<%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1">$<%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                    <td  class="STableR1">&nbsp;</td>
                    <td  class="STableR1">&nbsp;</td>
                </tr><%if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2">$<%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2">$<%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2">$<%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                    <td  class="STableR2">&nbsp;</td>
                    <td  class="STableR2">&nbsp;</td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1">$<%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1">$<%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1">$<%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                    <td  class="STableR1">&nbsp;</td>
                    <td  class="STableR1">&nbsp;</td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2">$<%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2">$<%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2">$<%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                    <td  class="STableR2">&nbsp;</td>
                    <td  class="STableR2">&nbsp;</td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=rs.getString(2)%></td>
                    <td class="STableR1"><%=rs.getString(3)%></td>
                    <td class="STableR1">$<%=rs.getString(4)%></td>
                    <td class="STableR1"><%=rs.getString(5)%></td>
                    <td class="STableR1">$<%=rs.getString(6)%></td>
                    <td class="STableR1"><%=rs.getString(7)%></td>
                    <td class="STableR1"><%=rs.getString(8)%></td>
                    <td class="STableR1"><%=rs.getString(9)%></td>
                    <td class="STableR1">$<%=rs.getString(10)%></td>
                    <td class="STableR1"><%=rs.getString(11)%></td>
                    <td class="STableR1"><%=rs.getString(12)%></td>
                    <td class="STableR1"><%=rs.getString(13)%></td>
                    <td class="STableR1"><%=rs.getString(14)%></td>
                    <td  class="STableR1">&nbsp;</td>
                    <td  class="STableR1">&nbsp;</td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=rs.getString(2)%></td>
                    <td class="STableR2"><%=rs.getString(3)%></td>
                    <td class="STableR2">$<%=rs.getString(4)%></td>
                    <td class="STableR2"><%=rs.getString(5)%></td>
                    <td class="STableR2">$<%=rs.getString(6)%></td>
                    <td class="STableR2"><%=rs.getString(7)%></td>
                    <td class="STableR2"><%=rs.getString(8)%></td>
                    <td class="STableR2"><%=rs.getString(9)%></td>
                    <td class="STableR2">$<%=rs.getString(10)%></td>
                    <td class="STableR2"><%=rs.getString(11)%></td>
                    <td class="STableR2"><%=rs.getString(12)%></td>
                    <td class="STableR2"><%=rs.getString(13)%></td>
                    <td class="STableR2"><%=rs.getString(14)%></td>
                    <td  class="STableR2">&nbsp;</td>
                    <td  class="STableR2">&nbsp;</td>
                </tr>            
                <%}%>
            </table>
        </div>
        <%
            StrSql.delete(0,StrSql.length());
            rs = null;
            }
                    
            String insert= " Insert into BitacoraReportes (InicioEjecucion,FinEjecucion,TiempoEjecucion,QueryEjecutado,clUsrApp) values (";
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
                    }
                    
                }
        %>
        <script>
            document.all.clAnioC.disabled=false;
            document.all.clmesC.disabled=false;
            document.all.clTipoC.disabled=false;
        </script>
    </body>
</html>
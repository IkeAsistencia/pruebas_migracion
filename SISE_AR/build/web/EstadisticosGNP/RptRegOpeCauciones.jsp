<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Timestamp,java.util.Calendar,Utilerias.Grafica,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Registro de la Operacion Cauciones</title>
        <link href="../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}            
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableGpo {background-color: #ffffff;}
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}            
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;} 
            .STableReg{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
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
            StringBuffer StrSqlG1 = new StringBuffer();
            StringBuffer StrSqlG2 = new StringBuffer();
            String StrclUsrApp="0";
            String StrclAnio = "";
            String clMes = "";
            String clTipo = "0";
            String dsTipoExped = "";
            String Mes = "";
            String StrRow = "";
            String StrQry="";
            String StrInicia="";            
            int clAnio=0;

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
                MyUtil.InicializaParametrosC(701,Integer.parseInt(StrclUsrApp));
        %>
        <form name='frmBusq' id='frmBusq' method='post' action='../EstadisticosGNP/RptRegOpeCauciones.jsp'>
            <%=MyUtil.ObjComboC("Año","clAnio","",true,true,20,30,"","st_GetAnio2","","",25,true,true)%>
            <%=MyUtil.ObjComboC("Cauciones","clTipo","",true,true,180,30,"","Select '1' 'clTipo','Exhibidas' 'dsTipo' Union Select '2' 'clTipo','Recuperadas' 'dsTipo'","","",25,true,true)%>
            <%=MyUtil.DoBlock("Parametros de Busqueda",70,0)%>
            <div class='VTable' style='position:absolute; z-index:30; left:350px; top:41px;'> 
                <input type="button" class="cBtn" value="Buscar.." onclick="this.form.submit();">
            </div>
        </form>
        <%
            if(request.getParameter("clAnio")!= null){
                StrclAnio = request.getParameter("clAnio");
                clAnio= Integer.parseInt(StrclAnio);
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

                    if(clTipo.equalsIgnoreCase("1")){dsTipoExped = "EXHIBIDAS"; } else if(clTipo.equalsIgnoreCase("2")){dsTipoExped = "RECUPERADAS"; }
                }
            }

            StrSql.append("st_GNPRptRegOpeCauciones '").append(StrclAnio).append("','").append(clTipo).append("'").append(",'1'");
            StrQry="st_GNPRptRegOpeCauciones "+StrclAnio+","+clTipo;

            //System.out.println(StrSql.toString());
            ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());

            java.sql.ResultSetMetaData infoResulSet =   null;
            infoResulSet = rs.getMetaData();

            if(infoResulSet.getColumnCount() != 1){

                if(rs.next()){
        %> 
        <div style='position:absolute; z-index:20; left:10px; top:120px;'> 
            <font class="STableTitRpt"> <center>Registro de la Operacion<br><br>Acumulado <%=clAnio%></center> </font><br>
            <table width="105%" border="0" cellspacing="1" cellpadding="1">
                <tr> 
                    <td colspan="3" class="STableTit">CAUCIONES <%=dsTipoExped%></td>
                    <td width="4%" class="STableTit">ENE</td>
                    <td width="4%" class="STableTit">FEB</td>
                    <td width="4%" class="STableTit">MAR</td>
                    <td width="4%" class="STableTit">ABR</td>
                    <td width="4%" class="STableTit">MAY</td>
                    <td width="4%" class="STableTit">JUN</td>
                    <td width="4%" class="STableTit">JUL</td>
                    <td width="4%" class="STableTit">AGO</td>
                    <td width="4%" class="STableTit">SEP</td>
                    <td width="4%" class="STableTit">OCT</td>
                    <td width="4%" class="STableTit">NOV</td>
                    <td width="4%" class="STableTit">DIC</td>
                    <td width="4%" class="STableTit">ACUMULADO A</td>
                    <td width="4%" class="STableTit">ACUMULUDADO ANUAL</td>
                </tr>
                <tr> 
                    <td width="6%" rowspan="3" class="STableTexto">NORTE</td>
                    <td width="4%" class="STableR1"><%=clAnio-1%></td>
                    <td width="2%" rowspan="3" class="STableTexto">N&deg;</td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=clAnio%></td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    
                    <td class="STableR1">% DIF</td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td rowspan="3" class="STableTexto">PACIFICO (GUADALAJARA)</td>
                    <td class="STableR2"><%=clAnio-1%></td>
                    <td rowspan="3" class="STableTexto">N&deg;</td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=clAnio%></td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    
                    <td class="STableR2">% DIF</td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td rowspan="3" class="STableTexto">PACIFICO (MEXICALI)</td>
                    <td class="STableR1"><%=clAnio-1%></td>
                    <td rowspan="3" class="STableTexto">N&deg;</td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=clAnio%></td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    
                    <td class="STableR1">% DIF</td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td rowspan="3" class="STableTexto">PERIFERIA</td>
                    <td class="STableR2"><%=clAnio-1%></td>
                    <td rowspan="3" class="STableTexto">N&deg;</td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR1"><%=clAnio%></td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    
                    <td class="STableR2">% DIF</td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td rowspan="3" class="STableTexto">SUR</td>
                    <td class="STableR1"><%=clAnio-1%></td>
                    <td rowspan="3" class="STableTexto">N&deg;</td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableR2"><%=clAnio%></td>
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
                    <td class="STableR2"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    
                    <td class="STableR1">% DIF</td>
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
                    <td class="STableR1"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td rowspan="3" class="STableTit">TOTAL</td>
                    <td class="STableTit"><%=clAnio-1%></td>
                    <td rowspan="3" class="STableTit">N&deg;</td>
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
                    <td class="STableTit"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    <td class="STableTit"><%=clAnio%></td>
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
                    <td class="STableTit"><%=rs.getString(15)%></td>
                </tr><%}if(!rs.isLast()){rs.next();%>
                <tr> 
                    
                    <td class="STableTit">% DIF</td>
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
                    <td class="STableTit"><%=rs.getString(15)%></td>
                </tr> 
                <%}%>
            </table>
        </div>
        <%
            StrSql.delete(0,StrSql.length());
            rs = null;
            }

            StrSqlG1.append("st_GNPRptRegOpeCauciones'").append(StrclAnio).append("','").append(clTipo).append("'").append(",'2'");
            StrSqlG2.append("st_GNPRptRegOpeCauciones'").append(StrclAnio).append("','").append(clTipo).append("'").append(",'3'");
        %>
        <div style='position:absolute; z-index:20; left:10px; top:530px;'>            
            <IMG SRC="..\\SGrafica?type=<%=StrSqlG1.toString()%>&dsCampo=Regional&dsCampoCan=&Tipo=4&Pagina=689&Titulo=Acumulado Por Centro Regional" BORDER=1/>            
        </div> 
        <div style='position:absolute; z-index:20; left:530px; top:530px;'>            
            <IMG SRC="..\\SGrafica?type=<%=StrSqlG2.toString()%>&dsCampo=Regional&dsCampoCan=&Tipo=5&Pagina=689&Titulo=Acumulado Nacional" BORDER=1/>
        </div>
        
       
        <%
            StrSqlG1.delete(0,StrSqlG1.length());
            StrSqlG2.delete(0,StrSqlG2.length());
            
            String insert = " Insert into BitacoraReportes (InicioEjecucion,FinEjecucion,TiempoEjecucion,QueryEjecutado,clUsrApp) values (";
            UtileriasBDF.ejecutaSQLNP(insert+"'"+StrInicia+ "','"+StrInicia+"',"+((System.currentTimeMillis()-tiempo)/1000)+",'"+StrQry+"',"+StrclUsrApp+")");                    
            StrInicia=null;
            StrQry=null;
            insert=null;
            StrSql=null;
            StrSqlG1=null;
            StrSqlG2=null;
            
            }else{
                if(rs.next()){
        %>
        <div style='position:absolute; z-index:20; left:10px; top:120px;'>
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
            document.all.clTipoC.disabled=false;
        </script>
    </body>
</html>
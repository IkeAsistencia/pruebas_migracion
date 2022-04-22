<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.Timestamp,java.util.Calendar,java.util.Iterator,java.util.Map,java.util.LinkedHashMap,Utilerias.Grafica,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Registro de la Operacion Asuntos Turnados vs Terminados</title>
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
            String StrclUsrApp="0";
            String StrclAnio = "";
            String clMes = "0";
            String clTipo = "0";
            String dsTipoExped = "";
            String Mes = "";
            String StrRow = "";
            int NumRows =0;
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
                MyUtil.InicializaParametrosC(694,Integer.parseInt(StrclUsrApp));
        %>
        <form name='frmBusq' id='frmBusq' method='post' action='../EstadisticosGNP/RptRegistroOpexEstado.jsp'>
            <%=MyUtil.ObjComboC("Año","clAnio","",true,true,20,30,"","st_GetAnio2","","",25,true,true)%>
            <%--=MyUtil.ObjComboC("Mes","clmes","",true,true,180,30,"","sp_MesesEnCurso","","",25,true,true)--%>
            <%=MyUtil.ObjComboC("Mes","clmes","",true,true,180,30,"","sp_NombreMeses","","",25,true,true)%> 
            <%=MyUtil.ObjComboC("Expedientes","clTipo","",true,true,340,30,"","Select '1' 'clTipo','Turnados' 'dsTipo' Union Select '2' 'clTipo','Terminados' 'dsTipo'","","",25,true,true)%>
            <%=MyUtil.DoBlock("Parametros de Busqueda",70,0)%>
            <div class='VTable' style='position:absolute; z-index:30; left:515px; top:41px;'> 
                <input type="button" class="cBtn" value="Buscar.." onclick="this.form.submit();">
            </div>
        </form>
        <%
            if(request.getParameter("clAnio")!= null){
                        StrclAnio = request.getParameter("clAnio");
                        clAnio=Integer.parseInt(StrclAnio);
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

                            if(clTipo.equalsIgnoreCase("1")){dsTipoExped = "TURNADOS"; } else if(clTipo.equalsIgnoreCase("2")){dsTipoExped = "TERMINADOS"; }
                        }
                    }

                    StrSql.append("st_GNPRptRegistroOperacionXEdo '").append(StrclAnio).append("','").append(clMes).append("','").append(clTipo).append("'");
                    StrQry="st_GNPRptRegistroOperacionXEdo "+StrclAnio+","+clMes+","+clTipo;
                    
                    //System.out.println(StrSql.toString());
                    ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());

                    java.sql.ResultSetMetaData infoResulSet =   null;
                    infoResulSet = rs.getMetaData();

                    Map MapEstructuraTabla = new LinkedHashMap();

                    String strRegional = "";
                    String strRegionalAux = "";
                    int Contador = 1;

                    if(infoResulSet.getColumnCount() != 1){

                        if(rs.next()){
                            strRegional = rs.getString(2);
                            if(!rs.isLast()){rs.next();}
                            do{
                                strRegionalAux = rs.getString(2);
                                if(strRegional.equalsIgnoreCase(strRegionalAux)){
                                    Contador++;
                                }else{
                                    MapEstructuraTabla.put(strRegional,Integer.toString(Contador));
                                    if(rs.next()){
                                        strRegional = rs.getString(2);
                                        Contador = 1;
                                    }
                                }
                            }while(rs.next());
                            rs.first();

                            Iterator it = MapEstructuraTabla.keySet().iterator();

                            String key = null;
                            String pvalue = null;
        %> 
        <div style='position:absolute; z-index:20; left:10px; top:120px;'> 
            <font class="STableTitRpt"> <center>Registro de la Operacion</center> </font>
            <br>            
            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr><td colspan='6' class="STableTit">ASUNTOS <%=dsTipoExped%></tr>
                <tr><td colspan='6' class='STableTexto'>&nbsp;</tr>
                <tr> 
                    <td  class="STableTit">REGION</td>
                    <td  width="15%" class="STableTit">ESTADO</td>
                    <td  width="15%" class="STableTit"><%=Mes + " " + (clAnio - 1)%></td>
                    <td  width="15%" class="STableTit"><%=Mes + " " + clAnio%></td>
                    <td  width="15%" class="STableTit">DIF</td>
                    <td  width="15%" class="STableTit"><%="ACUMULADO " +clAnio%> </td>
                </tr>
                <%
                    while(it.hasNext()){
                key = ( String ) it.next();
                pvalue = ( String ) MapEstructuraTabla.get(key);
                for(int rows = 1; rows <= Integer.parseInt(pvalue);rows++){
                    switch( rows % 2 ){
                        case 0 : StrRow = "STableR1"; break;
                        case 1 : StrRow = "STableR2"; break;
                    }
                %> <tr class='<%=StrRow%>'><%
                   
                    if(rows == 1){ 
                %> <td rowspan='<%=pvalue%>' class='STableReg'> <%=key%></td><%
                    } 
                    %> 
                    <td><%=rs.getString(3)%></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getString(5)%></td>
                    <td><%=rs.getString(6)%></td>
                    <td><%=rs.getString(7)%></td>
                    </tr>
                    <%
                    if(!rs.isLast()){rs.next();}
                }   
                %>
                <tr>
                <td colspan='2' class='STableTit'><%=rs.getString(2)%></td>
                <td class='STableTit'><%=rs.getString(4)%></td>
                <td class='STableTit'><%=rs.getString(5)%></td>
                <td class='STableTit'><%=rs.getString(6)%></td>
                <td class='STableTit'><%=rs.getString(7)%></td>
                </tr>
<%
                if(!rs.isLast()){rs.next();}
                    }  %>                               
            <tr>
            <td colspan='2' class='STableTit'><%=rs.getString(2)%></td>
            <td class='STableTit'><%=rs.getString(4)%></td>
            <td class='STableTit'><%=rs.getString(5)%></td>
            <td class='STableTit'><%=rs.getString(6)%></td>
            <td class='STableTit'><%=rs.getString(7)%></td>
            </tr>
                                                
            </table>
        </div>
        <%
            StrSql.delete(0,StrSql.length());
            rs = null;
            
            String insert = " Insert into BitacoraReportes (InicioEjecucion,FinEjecucion,TiempoEjecucion,QueryEjecutado,clUsrApp) values (";
            UtileriasBDF.ejecutaSQLNP(insert+"'"+StrInicia+ "','"+StrInicia+"',"+((System.currentTimeMillis()-tiempo)/1000)+",'"+StrQry+"',"+StrclUsrApp+")");                    
            StrInicia=null;
            StrQry=null;
            insert=null;
            
           
            }
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
            document.all.clTipoC.disabled=false;
            document.all.clAnioC.disabled=false;
            document.all.clmesC.disabled=false;            
        </script>
    </body>
</html>
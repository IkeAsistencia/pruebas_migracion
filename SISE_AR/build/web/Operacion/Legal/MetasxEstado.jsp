<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="Utilerias.UtileriasBDF,java.util.Iterator,java.util.Map,java.util.LinkedHashMap,java.util.Date,java.sql.ResultSet,Utilerias.UtileriasBDF,Seguridad.SeguridadC" errorPage="" %>
<%@page pageEncoding="iso-8859-1"%>
<html>
    <head><title>Reporte de Cauciones Pendientes</title>
        <link href="../../StyleClasses/Global.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .STableTitRpt {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 13px; color: #000000; text-transform: uppercase;text-align: center;font-weight:bold;}            
            .STableTit {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #FFFFFF; text-transform: uppercase;text-align: center;background-color: #000066;}
            .STableGpo {background-color: #ffffff;}
            .STableTexto{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
            .STableR1{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;background-color: #FFFFFF;}            
            .STableR2{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;} 
            .STableReg{font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9px; color: #000000; text-transform: uppercase;text-align: center;}
        </style>
    </head>
    <body class="cssBody">
        <jsp:useBean id="MyUtil" scope="session" class="Utilerias.UtileriasObj" /> 
        <script src='../../Utilerias/Util.js' ></script>
        <script src='../../Utilerias/UtilMask.js'></script>       
        <%                                
            StringBuffer StrSql = new StringBuffer();
            StringBuffer strSalida = new StringBuffer();
            String StrclUsrApp="0";
            String StrclAnio = "";
            String clMes = "0";
            String clTipo = "0";
            String dsTipoExped = "";
            String Mes = "";
            String StrRow = "";
            int NumRows =0;



            if (session.getAttribute("clUsrApp")!= null) {
                StrclUsrApp = session.getAttribute("clUsrApp").toString();
            }

            if (SeguridadC.verificaHorarioC(Integer.parseInt(StrclUsrApp)) != true) {
        %>Fuera de Horario<%
            StrclUsrApp=null;
            return;
                }
                MyUtil.InicializaParametrosC(704,Integer.parseInt(StrclUsrApp));

                StrSql.append("st_GNPMetasxEstado");

                ResultSet rs = UtileriasBDF.rsSQLNP( StrSql.toString());

                java.sql.ResultSetMetaData infoResulSet =   null;
                infoResulSet = rs.getMetaData();

                Map MapEstructuraTabla = new LinkedHashMap();

                String strRegional = "";
                String strRegionalAux = "";
                int Contador = 1;

                if(infoResulSet.getColumnCount() != 1)
                {
                    if(rs.next())
                    {
                        strRegional = rs.getString(2);
                        if(!rs.isLast())
                        {
                            rs.next();
                        }
                      
                        do{
                            strRegionalAux = rs.getString(2);
                            if(strRegional.equalsIgnoreCase(strRegionalAux))
                            {
                                Contador++;
                            }
                            else
                            {
                                MapEstructuraTabla.put(strRegional,Integer.toString(Contador));
                                if(rs.next())
                                {
                                    strRegional = rs.getString(2);
                                    Contador = 2;
                                }
                            }
                        }while(rs.next());
                        MapEstructuraTabla.put(strRegional,Integer.toString(Contador));
                        rs.first();

                        Iterator it = MapEstructuraTabla.keySet().iterator();

                        String key = null;
                        String pvalue = null;
        %> 
        <div style='position:absolute; z-index:20; left:10px; top:50px;'> 
            <font class="STableTitRpt"> <center>Metas de indicadores de desempeño por Estado</center> </font>
            <br>            
            <table width="100%" border="1" cellspacing="1" cellpadding="1">
                <tr> 
                    <td  width="15%" class="STableTit">CENTRO REGIONAL</td>
                    <td  width="15%" class="STableTit">ESTADO</td>
                    <td  width="15%" class="STableTit">TIEMPO DE ARRIBO (MAXIMO EN MINUTOS)</td>
                    <td  width="15%" class="STableTit">TIEMPO DE LIBERACION DE PERSONAS (MAXIMO EN HORAS)</td>
                    <td  width="15%" class="STableTit">TIEMPO DE LIBERACION DE VEHICULOS (MAXIMO EN DIAS HABILES)</td>
                    <td  width="15%" class="STableTit">TIEMPO DE SOLUCIÓN O CIERRE DE ASUNTOS (MAXIMO EN MESES)</td>
                </tr>
                <%
                    do{
                key = ( String ) it.next();
                pvalue = ( String ) MapEstructuraTabla.get(key);
                for(int rows = 1; rows <= Integer.parseInt(pvalue);rows++){
                    switch( rows % 2 ){
                        case 0 : StrRow = "STableR1"; break;
                        case 1 : StrRow = "STableR2"; break;
                    }
                    out.println("<tr class='"+StrRow+ "'>");
                    if(rows == 1){
                        out.println("<td rowspan='"+ pvalue +"' class='STableReg'>"+key+"</td>");
                    }
                    out.println("<td>"+rs.getString(3)+"</td>");
                    out.println("<td>"+rs.getString(4)+"</td>");
                    out.println("<td>"+rs.getString(5)+"</td>");
                    out.println("<td>"+rs.getString(6)+"</td>");
                    out.println("<td>"+rs.getString(7)+"</td>");

                    out.println("</tr>");
                    if(!rs.isLast()){rs.next();}
                }
                    }while(it.hasNext());

                %>
            </table> <br>               
            <%
                StrSql.delete(0,StrSql.length());
                rs = null;
            %>   
        </div>
        <%
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
    </body>
</html>